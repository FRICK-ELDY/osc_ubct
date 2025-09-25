//! summary: 送信ON/OFFトグルなどの操作ロジック（MethodChannel連携）
//! path: example/lib/ui/osc_sender_panel/osc_sender_panel_actions.dart

part of ui.osc_sender_panel;

/// View から呼ぶ操作の“約束”
abstract class _OscSenderAPI {
  Future<void> toggleSend(bool value);
}

mixin OscSenderPanelActions on State<OscSenderPanel>
    implements _OscSenderAPI {
  OscSenderPanelState get _st => this as OscSenderPanelState;

  @override
  Future<void> toggleSend(bool value) async {
    setState(() => _st.isSending = value);
    final method = value ? 'startSending' : 'stopSending';
    try {
      await _osc_ubct.invokeMethod(method, <String, dynamic>{});
    } catch (e) {
      debugPrint('Failed to toggle OSC sending: $e');
    }
  }
}
