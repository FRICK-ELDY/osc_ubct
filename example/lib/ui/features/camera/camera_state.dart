//! summary: Cameraの状態（UI用）。joints/Euler 値やプレビュー画像を保持
//! path: example/lib/ui/features/camera/camera_state.dart

import 'dart:ui' as ui; // プレビュー画像保持用
import '../../../models/euler.dart';

class CameraState {
  // ▼ ネイティブ列挙の結果を保持
  List<String> availableCameras = const [];
  Map<String, int> nativeCameraIndexByLabel = {};
  String? selectedCamera; // 初回は null。loadNativeCameras() で先頭を入れる

  // 上半身トラッキング用モデル
  static const List<String> models = [
    'Auto (Recommended)',
    'MediaPipe Upper Body',
    'MoveNet (Lightning)',
    'MoveNet (Thunder)',
    'BlazePose Upper',
    'OpenPose Upper',
    'YOLOv8-Pose (Upper)',
  ];
  String selectedModel = models.first;

  // 状態
  bool tracking = false;
  int pullIntervalMs = 100; // 100ms デフォ
  int frameCount = 0;

  // 表示切替
  bool showPreview = false;
  bool showData = false;
  bool showPull = false;

  // joints（モック/実データ双方で使用）
  static const List<String> joints = [
    'neck',
    'shoulder_l', 'shoulder_r',
    'elbow_l', 'elbow_r',
    'wrist_l', 'wrist_r',
  ];
  final Map<String, Euler> jointEuler = {
    for (final j in joints) j: const Euler(0, 0, 0),
  };

  ui.Image? previewImage;

  void setEuler(String joint, double r, double p, double y) {
    jointEuler[joint] = Euler(r, p, y);
  }

  void clearPreview() {
    previewImage?.dispose();
    previewImage = null;
  }

  void dispose() {
    clearPreview();
  }
}
