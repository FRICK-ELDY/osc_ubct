//! summary: FRBに合わせたCamera制御。JPG取得→ui.Image化、JSON→Euler反映、OSC送信はOscRuntimeへ
//! path: example/lib/ui/features/camera/camera_actions.dart

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'camera_state.dart';
import '../settings/display_settings_sheet.dart';
import '../../../models/euler.dart';
import '../../../services/runtime/osc_runtime.dart';

// FRB 生成コード（プロジェクトに合わせて相対パスを調整）
import '../../../src/rust/api/camera.dart' as cam_api;
import '../../../src/rust/api/tracking.dart' as tr_api;

class CameraActions {
  final CameraState state;
  final VoidCallback refresh;
  Timer? _pullTimer;

  // FRBハンドル
  cam_api.Camera? _cam;
  tr_api.Tracker? _tracker;

  // プレビュー取得の多重呼び出し防止
  bool _gettingPreview = false;

  CameraActions(this.state, this.refresh);

  // === ネイティブのカメラ一覧 ===
  Future<void> loadNativeCameras() async {
    // 現状のFRBサンプルAPIは列挙を提供していないため、既定の index=0 を提示
    state.availableCameras = const ['Default Camera (0)'];
    state.nativeCameraIndexByLabel = {'Default Camera (0)': 0};
    state.selectedCamera ??= state.availableCameras.first;
    refresh();
  }

  void toggleTracking(BuildContext context) {
    state.tracking ? stopTracking(context) : startTracking(context);
  }

  Future<void> startTracking(BuildContext context) async {
    if (state.selectedCamera == null) {
      _snack(context, 'カメラが選択されていません');
      return;
    }

    // 既存のタイマー/ハンドルは一旦停止
    _stopPullTimer();

    // カメラ/トラッカーを起動（FRB）
    final camIdx = state.nativeCameraIndexByLabel[state.selectedCamera] ?? 0;
    _cam = await cam_api.cameraOpen(index: camIdx, w: 640, h: 480, fps: 30);
    _tracker = await tr_api.trackingInit(modelPath: null);

    state.tracking = true;
    state.frameCount = 0;

    _startPullTimer();
    refresh();
  }

  void stopTracking(BuildContext context) {
    _stopPullTimer();
    _cam = null;
    _tracker = null;
    state.tracking = false;
    state.clearPreview();
    refresh();
  }

  void _startPullTimer() {
    _pullTimer?.cancel();
    _pullTimer = Timer.periodic(Duration(milliseconds: state.pullIntervalMs), (_) async {
      // 1) プレビュー（ONのときのみ）
      if (state.showPreview && !_gettingPreview && _cam != null) {
        _gettingPreview = true;
        try {
          final frame = await cam_api.cameraGrabJpeg(cam: _cam!, quality: 80);
          final img = await _decodeJpeg(frame.jpeg);
          state.previewImage?.dispose();
          state.previewImage = img;
        } catch (_) {
          // 無視して継続
        } finally {
          _gettingPreview = false;
          refresh();
        }
      }

      // 2) トラッキングJSONの取得→状態反映→OSC送信（有効時）
      if (_tracker != null) {
        try {
          final bytes = await tr_api.trackingLatestJson(tr: _tracker!);
          if (bytes.isNotEmpty) {
            _applyNativeJson(bytes);
            await OscRuntime.sendJsonIfEnabled(Uint8List.fromList(bytes));
          }
        } catch (_) {
          // JSON取得失敗は無視
        }
      }

      // 3) フレームカウント
      state.frameCount++;
      refresh();
    });
  }

  void _stopPullTimer() {
    _pullTimer?.cancel();
    _pullTimer = null;
    _gettingPreview = false;
  }

  void onCameraSelected(String label) {
    state.selectedCamera = label;
    refresh();
  }

  void onPullIntervalChanged(int ms) {
    state.pullIntervalMs = ms;
    if (state.tracking) _startPullTimer();
    refresh();
  }

  void onModelChanged(String v, BuildContext context) {
    state.selectedModel = v; // 現状はUIのみ保持（推論器切替は後続で実装）
    refresh();
    _snack(context, 'Model: $v');
  }

  void openDisplaySettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => DisplaySettingsSheet(
        initialPreview: state.showPreview,
        initialData: state.showData,
        initialPull: state.showPull,
        onPreviewChanged: (v) {
          state.showPreview = v;
          if (!v) state.clearPreview();
          refresh();
        },
        onDataChanged: (v) { state.showData = v; refresh(); },
        onPullChanged: (v) { state.showPull = v; refresh(); },
      ),
    );
  }

  void dispose() {
    _stopPullTimer();
    state.dispose();
  }

  // ---- helpers ----
  Future<ui.Image> _decodeJpeg(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void _applyNativeJson(List<int> jsonBytes) {
    try {
      final map = json.decode(utf8.decode(jsonBytes)) as Map<String, dynamic>;

      // 1) joints 形式（{ joints: { name: {r,p,y} } })
      final joints = map['joints'];
      if (joints is Map<String, dynamic>) {
        Euler parse(Map<String, dynamic> m) =>
            Euler((m['r'] ?? 0).toDouble(), (m['p'] ?? 0).toDouble(), (m['y'] ?? 0).toDouble());
        for (final name in CameraState.joints) {
          final m = joints[name];
          if (m is Map<String, dynamic>) {
            state.jointEuler[name] = parse(m);
          }
        }
        return;
      }

      // 2) angle 形式（{ angle: {r,p,y} }）→ neck に割り当て
      final angle = map['angle'];
      if (angle is Map<String, dynamic>) {
        final e = Euler((angle['r'] ?? 0).toDouble(), (angle['p'] ?? 0).toDouble(), (angle['y'] ?? 0).toDouble());
        state.jointEuler['neck'] = e;
        return;
      }
    } catch (_) {
      // パース失敗時は下のUIモックへフォールバック
    }

    // ---- ネイティブ無/異常時モック（既存UIと同じ挙動） ----
    final t = DateTime.now().millisecondsSinceEpoch / 1000.0;
    final a = t * 2 * math.pi * 0.5;
    final sin = math.sin(a);
    final cos = math.cos(a);
    state.setEuler('neck', 10 * sin, 5 * cos, 8 * math.sin(1.1 * a));
    state.setEuler('shoulder_l', 20 * sin, 15 * math.sin(0.7 * a), 10 * cos);
    state.setEuler('shoulder_r', -18 * sin, 15 * math.sin(0.7 * a), -10 * cos);
    state.setEuler('elbow_l', 30 * math.sin(0.8 * a), 0, 0);
    state.setEuler('elbow_r', -30 * math.sin(0.8 * a), 0, 0);
    state.setEuler('wrist_l', 12 * math.sin(1.3 * a), 6 * math.cos(1.1 * a), 0);
    state.setEuler('wrist_r', -12 * math.sin(1.3 * a), 6 * math.cos(1.1 * a), 0);
  }

  void _snack(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }
}
