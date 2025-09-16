//! summary: 表示設定ボトムシート（Pull / Preview / Data）
//! path: example/lib/ui/features/settings/display_settings_sheet.dart

import 'package:flutter/material.dart';

class DisplaySettingsSheet extends StatefulWidget {
  final bool initialPreview;
  final bool initialData;
  final bool initialPull;
  final ValueChanged<bool> onPreviewChanged;
  final ValueChanged<bool> onDataChanged;
  final ValueChanged<bool> onPullChanged;

  const DisplaySettingsSheet({
    super.key,
    required this.initialPreview,
    required this.initialData,
    required this.initialPull,
    required this.onPreviewChanged,
    required this.onDataChanged,
    required this.onPullChanged,
  });

  @override
  State<DisplaySettingsSheet> createState() => _DisplaySettingsSheetState();
}

class _DisplaySettingsSheetState extends State<DisplaySettingsSheet> {
  late bool _preview = widget.initialPreview;
  late bool _data = widget.initialData;
  late bool _pull = widget.initialPull;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('表示設定', style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                IconButton(
                  tooltip: '閉じる',
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(height: 8),
            SwitchListTile(
              title: const Text('Pull表示'),
              value: _pull,
              onChanged: (v) {
                setState(() => _pull = v);
                widget.onPullChanged(v);
              },
              secondary: const Icon(Icons.speed_outlined),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Preview表示'),
              value: _preview,
              onChanged: (v) {
                setState(() => _preview = v);
                widget.onPreviewChanged(v);
              },
              secondary: const Icon(Icons.video_camera_front_outlined),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Data表示'),
              value: _data,
              onChanged: (v) {
                setState(() => _data = v);
                widget.onDataChanged(v);
              },
              secondary: const Icon(Icons.list_alt_outlined),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.tonal(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
