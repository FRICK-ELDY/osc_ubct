//! summary: State（フォーム＋送信設定管理）
//! path: example/lib/ui/osc_sender_panel/osc_sender_panel_state.dart

part of ui.osc_sender_panel;

class OscSenderPanelState extends State<OscSenderPanel>
    with OscSenderPanelActions, OscSenderPanelView {
  final formKey = GlobalKey<FormState>();

  // 状態
  bool isSending = false;
  bool sendContinuously = true;
  double rateLimitHz = 60.0;

  // 設定
  String host = '127.0.0.1';
  int port = 9000;
  String defaultAddress = '/ubct';

  // Controller
  late final TextEditingController hostCtl;
  late final TextEditingController portCtl;
  late final TextEditingController addrCtl;

  @override
  void initState() {
    super.initState();
    hostCtl = TextEditingController(text: host);
    portCtl = TextEditingController(text: port.toString());
    addrCtl = TextEditingController(text: defaultAddress);
  }

  @override
  void dispose() {
    hostCtl.dispose();
    portCtl.dispose();
    addrCtl.dispose();
    super.dispose();
  }

  // バリデータ
  String? validateHost(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'ホスト名またはIPを入力してください';
    return null;
  }

  String? validatePort(String? v) {
    final s = (v ?? '').trim();
    final n = int.tryParse(s);
    if (n == null || n < 1 || n > 65535) return '1〜65535の範囲で入力してください';
    return null;
  }

  String? validateAddress(String? v) {
    final s = (v ?? '').trim();
    if (s.isEmpty) return 'OSCアドレスを入力してください';
    if (!s.startsWith('/')) return '先頭は / から始めてください';
    return null;
  }

  void saveFormToState() {
    if (formKey.currentState?.validate() ?? false) {
      host = hostCtl.text.trim();
      port = int.parse(portCtl.text.trim());
      defaultAddress = addrCtl.text.trim();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => buildOscSenderPanel(context);
}
