//! summary: Camera UIカード。プレビューの RawImage 表示や各種設定UI
//! path: example/lib/ui/features/camera/camera_view.dart

import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../common_view/app_card.dart';
import 'camera_state.dart';
import 'camera_actions.dart';

class CameraView extends StatefulWidget {
  final CameraState state;
  final CameraActions actions;
  const CameraView({super.key, required this.state, required this.actions});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  void initState() {
    super.initState();
    // 画面がマウントされた直後に一度だけカメラ列挙
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.actions.loadNativeCameras();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final state = widget.state;
    final actions = widget.actions;
    final hasCams = state.availableCameras.isNotEmpty;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // タイトル + 歯車 + リフレッシュ
          Row(
            children: [
              const Text('Camera'),
              const Spacer(),
              IconButton(
                tooltip: 'カメラを再スキャン',
                icon: const Icon(Icons.refresh),
                onPressed: actions.loadNativeCameras,
              ),
              IconButton(
                tooltip: '表示設定',
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => actions.openDisplaySettings(context),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // カメラ選択
          DropdownButton<String>(
            isExpanded: true,
            value: hasCams ? state.selectedCamera : null,
            items: state.availableCameras
                .map((label) =>
                    DropdownMenuItem(value: label, child: Text(label)))
                .toList(),
            hint: Text(
              hasCams ? 'カメラを選択' : 'カメラが見つかりません（🔄で再スキャン）',
            ),
            onChanged: hasCams
                ? (v) {
                    if (v != null) actions.onCameraSelected(v);
                  }
                : null,
          ),
          const SizedBox(height: 8),

          // モデル選択
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Tracking Model'),
            value: state.selectedModel,
            items: CameraState.models
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                .toList(),
            onChanged: (v) {
              if (v != null) actions.onModelChanged(v, context);
            },
          ),
          const SizedBox(height: 12),

          // トラッキング開始/停止
          Row(
            children: [
              FilledButton.icon(
                onPressed: () => actions.toggleTracking(context),
                icon: Icon(state.tracking ? Icons.stop : Icons.play_arrow),
                label:
                    Text(state.tracking ? 'トラッキング停止' : 'トラッキング開始'),
              ),
            ],
          ),

          // Pull スライダー（表示設定で ON のときのみ）
          if (state.tracking && state.showPull)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                children: [
                  const Text('Pull'),
                  Expanded(
                    child: Slider(
                      value: state.pullIntervalMs.toDouble(),
                      min: 10,
                      max: 200,
                      divisions: 19,
                      label: '${state.pullIntervalMs} ms',
                      onChanged: (v) =>
                          actions.onPullIntervalChanged(v.round()),
                    ),
                  ),
                  SizedBox(
                    width: 64,
                    child: Text(
                      '${state.pullIntervalMs} ms',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),

          // Preview（ネイティブ画像 + オーバーレイ）
          if (state.tracking && state.showPreview) ...[
            const SizedBox(height: 8),
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: cs.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // 画像本体
                  Align(
                    alignment: Alignment.center,
                    child: state.previewImage == null
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Preview: 読み込み中…'),
                          )
                        : RawImage(
                            image: state.previewImage,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.medium,
                          ),
                  ),
                  // 情報オーバーレイ（左上）— 解像度のみ。Pull は表示しない
                  if (_overlayText(state).isNotEmpty)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: _InfoBadge(
                        text: _overlayText(state),
                      ),
                    ),
                ],
              ),
            ),
          ],

          // Data
          if (state.tracking && state.showData) ...[
            const SizedBox(height: 8),
            Text(
              'OSC Payload:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            ...CameraState.joints.map((j) {
              final e = state.jointEuler[j]!;
              return Text(
                '$j: r=${e.r.toStringAsFixed(1)}°, p=${e.p.toStringAsFixed(1)}°, y=${e.y.toStringAsFixed(1)}°',
                style: const TextStyle(
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  // 解像度のみ返す。未取得なら空文字（→バッジ非表示）
  String _overlayText(CameraState s) {
    if (s.previewImage == null) return '';
    return '${s.previewImage!.width}x${s.previewImage!.height}';
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outline.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            height: 1.2,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ),
    );
  }
}
