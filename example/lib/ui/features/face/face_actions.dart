//! summary: 顔表情（UIのみ・モック送信）
//! path: example/lib/ui/features/face/face_actions.dart
import 'package:flutter/material.dart';
import 'face_state.dart';

class FaceActions {
  final FaceState state;
  final VoidCallback refresh;
  FaceActions(this.state, this.refresh);

  void sendFace(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('FaceExpression 送信 (UI only): ${state.faceExpr}')),
    );
  }
}
