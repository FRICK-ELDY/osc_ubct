//! summary: 送信ON/OFF状態などの State。本体は mixin に委譲。
//! path: example/lib/ui/osc_sender_panel/osc_sender_panel_state.dart

part of ui.osc_sender_panel;

class OscSenderPanelState extends State<OscSenderPanel>
    with OscSenderPanelActions, OscSenderPanelView {
  bool isSending = false;

  @override
  Widget build(BuildContext context) => buildOscSenderPanel(context);
}
