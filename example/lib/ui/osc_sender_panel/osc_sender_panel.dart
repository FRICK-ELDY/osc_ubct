//! summary: OSC送信パネル
//! path: example/lib/ui/osc_sender_panel/osc_sender_panel.dart

library ui.osc_sender_panel;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/info_card.dart';

part 'osc_sender_panel_state.dart';
part 'osc_sender_panel_actions.dart';
part 'osc_sender_panel_view.dart';

// ネイティブ連携用 MethodChannel
const MethodChannel _osc_ubct = MethodChannel('osc_ubct');

class OscSenderPanel extends StatefulWidget {
  const OscSenderPanel({super.key});

  @override
  State<OscSenderPanel> createState() => OscSenderPanelState();
}
