//! summary: 操作ロジック（送信On/Off, 連続送信切替, レート変更）
//! path: example/lib/ui/osc_sender_panel/osc_sender_panel_actions.dart

part of ui.osc_sender_panel;

/// Viewから呼ぶ操作の“約束”
abstract class _OscSenderAPI {
  Future<void> toggleSend(bool value);
  Future<void> toggleContinuous(bool value);
  Future<void> changeRate(double hz);
}

mixin OscSenderPanelActions on State<OscSenderPanel>
    implements _OscSenderAPI {
  OscSenderPanelState get _st => this as OscSenderPanelState;

  Future<void> _invoke(String method, [Map<String, dynamic>? args]) async {
    try {
      await _osc_ubct.invokeMethod(method, args ?? const <String, dynamic>{});
    } catch (e) {
      debugPrint('OSC method "$method" failed: $e');
    }
  }

  Future<void> _pushSettings() async {
    await _invoke('osc.updateSettings', {
      'host': _st.hostCtl.text.trim(),
      'port': int.tryParse(_st.portCtl.text.trim()) ?? _st.port,
      'defaultAddress': _st.addrCtl.text.trim(),
      'sendContinuously': _st.sendContinuously,
      'rateLimitHz': _st.rateLimitHz,
    });
  }

  @override
  Future<void> toggleSend(bool value) async {
    setState(() => _st.isSending = value);
    await _pushSettings();
    final method = value ? 'osc.startSending' : 'osc.stopSending';
    await _invoke(method);
  }

  @override
  Future<void> toggleContinuous(bool value) async {
    setState(() => _st.sendContinuously = value);
    await _pushSettings();
  }

  @override
  Future<void> changeRate(double hz) async {
    setState(() => _st.rateLimitHz = hz);
    await _pushSettings();
  }
}
