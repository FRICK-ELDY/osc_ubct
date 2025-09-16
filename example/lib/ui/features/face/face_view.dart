//! summary: 顔表情のUIカード
//! path: example/lib/ui/features/face/face_view.dart

import 'package:flutter/material.dart';
import '../../../common_view/app_card.dart';
import 'face_state.dart';
import 'face_actions.dart';

class FaceView extends StatelessWidget {
  final FaceState state;
  final FaceActions actions;
  const FaceView({super.key, required this.state, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Face Expression'),
          const SizedBox(height: 8),
          DropdownButton<int>(
            value: state.faceExpr,
            isExpanded: true,
            onChanged: (v) {
              if (v != null) {
                state.faceExpr = v;
                actions.refresh();
              }
            },
            items: const [
              DropdownMenuItem(value: 0, child: Text('Neutral')),
              DropdownMenuItem(value: 1, child: Text('Joy')),
              DropdownMenuItem(value: 2, child: Text('Anger')),
              DropdownMenuItem(value: 3, child: Text('Sad')),
              DropdownMenuItem(value: 4, child: Text('Excited')),
            ],
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => actions.sendFace(context),
            child: const Text('Send Face (mock)'),
          ),
        ],
      ),
    );
  }
}
