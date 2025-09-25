//! summary: MainPanel 親（library名方式で state / actions / view を分離）
//! path: example/lib/ui/main_panel/main_panel.dart

library ui.main_panel;

import 'package:flutter/material.dart';

import '../osc_sender_panel/osc_sender_panel.dart';

part 'main_panel_state.dart';
part 'main_panel_actions.dart';
part 'main_panel_view.dart';

class MainPanel extends StatefulWidget {
  final VoidCallback onUpdate;

  const MainPanel({
    super.key,
    required this.onUpdate,
  });

  @override
  State<MainPanel> createState() => MainPanelState();
}
