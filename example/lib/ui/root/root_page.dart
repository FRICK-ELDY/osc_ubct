//! summary: FRBバッジ（OK/NGともに）を完全に削除し、シンプルなヘッダのみのレイアウトにする
//! path: example/lib/ui/root/root_page.dart
import 'package:flutter/material.dart';

import '../features/camera/camera_state.dart';
import '../features/camera/camera_actions.dart';
import '../features/camera/camera_view.dart';

import '../features/osc/osc_state.dart';
import '../features/osc/osc_actions.dart';
import '../features/osc/osc_view.dart';

import '../features/face/face_state.dart';
import '../features/face/face_actions.dart';
import '../features/face/face_view.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    const phoneAspect = 9 / 19.5;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: LayoutBuilder(
        builder: (ctx, c) {
          final phoneWidth = c.maxWidth.clamp(360.0, 900.0);
          final phoneHeight = phoneWidth / phoneAspect;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: phoneWidth,
                maxHeight: phoneHeight,
              ),
              child: AspectRatio(
                aspectRatio: phoneAspect,
                child: const _Panel(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Panel extends StatefulWidget {
  const _Panel();

  @override
  State<_Panel> createState() => _PanelState();
}

class _PanelState extends State<_Panel> {
  late final CameraState _camera;
  late final CameraActions _cameraActions;

  late final OscState _osc;
  late final OscActions _oscActions;

  late final FaceState _face;
  late final FaceActions _faceActions;

  @override
  void initState() {
    super.initState();

    // States
    _camera = CameraState();
    _osc = OscState();
    _face = FaceState();

    // Actions（依存関係を注入）
    _cameraActions = CameraActions(_camera, _requestRebuild);
    _oscActions = OscActions(_osc, _camera, _requestRebuild);
    _faceActions = FaceActions(_face, _requestRebuild);
  }

  void _requestRebuild() => setState(() {});

  @override
  void dispose() {
    _cameraActions.dispose();
    _camera.dispose();

    _oscActions.dispose();
    _osc.dispose();

    _face.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)],
      ),
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Upper-Body Tracking Controller',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Camera & Tracking
          CameraView(state: _camera, actions: _cameraActions),

          const SizedBox(height: 12),

          // OSC
          OscView(state: _osc, actions: _oscActions),

          const SizedBox(height: 12),

          // Face
          FaceView(state: _face, actions: _faceActions),
        ],
      ),
    );
  }
}
