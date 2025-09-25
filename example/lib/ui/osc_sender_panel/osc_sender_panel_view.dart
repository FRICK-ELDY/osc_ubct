//! summary: UI構築（InfoCard／スイッチのみのシンプルビュー）
//! path: example/lib/ui/osc_sender_panel/osc_sender_panel_view.dart

part of ui.osc_sender_panel;

mixin OscSenderPanelView on State<OscSenderPanel>, _OscSenderAPI {
  Widget buildOscSenderPanel(BuildContext context) {
    final st = this as OscSenderPanelState;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "OSC Sender",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SwitchListTile(
            title: const Text("Enable OSC Sending"),
            value: st.isSending,
            onChanged: toggleSend,
          ),
        ],
      ),
    );
  }
}
