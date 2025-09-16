//! summary: FRB版OSC制御。ターゲット設定＆有効化のみ管理し、送信はOscRuntimeに委譲
//! path: example/lib/ui/features/osc/osc_actions.dart

import 'package:flutter/material.dart';
import '../camera/camera_state.dart';
import 'osc_state.dart';
import '../../../services/runtime/osc_runtime.dart';

class OscActions {
  final OscState state;
  final CameraState camera; // 送信有効化の前提チェック用
  final VoidCallback refresh;

  OscActions(this.state, this.camera, this.refresh);

  void toggleOscSending(BuildContext context) async {
    // Enable する場合は先にトラッキングが必要
    if (!state.oscSending && !camera.tracking) {
      _snack(context, '先にトラッキングを開始してください');
      return;
    }
    if (!state.isValidIp || !state.isValidPort) {
      _snack(context, 'IP/Port を確認してください');
      return;
    }

    // 先にターゲットを更新
    await OscRuntime.setTarget(state.ip, state.port!);

    // 送信 ON/OFF
    final next = !state.oscSending;
    await OscRuntime.setEnabled(next);
    state.oscSending = next;

    if (state.oscSending) state.oscTick++; // 簡易カウンタ（正確な送信数ではない）
    refresh();

    _snack(context, state.oscSending
        ? 'OSC送信: ${state.ip}:${state.port}'
        : 'OSC停止');
  }

  // トラッキング前に IP/Port だけ先に設定したい時用
  void applyTargetOnly(BuildContext context) async {
    if (!state.isValidIp || !state.isValidPort) {
      _snack(context, 'IP/Port を確認してください');
      return;
    }
    await OscRuntime.setTarget(state.ip, state.port!);
    _snack(context, 'ターゲットを更新しました');
  }

  Future<void> dispose() async {
    if (state.oscSending) {
      await OscRuntime.setEnabled(false);
      state.oscSending = false;
    }
  }

  void _snack(BuildContext context, String s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
  }
}
