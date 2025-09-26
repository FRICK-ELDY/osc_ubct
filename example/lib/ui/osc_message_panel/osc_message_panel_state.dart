//! summary: State／モデル（拡張引数。floatはmin/max保持＋起動時に1回updateMessage送信）
//! path: example/lib/ui/osc_message_panel/osc_message_panel_state.dart

part of ui.osc_message_panel;

/// 引数型
enum MsgArgType { float, int32, boolean, text }

/// 引数1つ分（float は min/max と値を持つ）
class MsgArg {
  MsgArgType type;
  dynamic value; // double | int | bool | String
  double? min;   // float のときのみ使用
  double? max;   // float のときのみ使用

  MsgArg.float({double v = 0.5, this.min = 0.0, this.max = 1.0})
      : type = MsgArgType.float,
        value = v;

  MsgArg.int32({int v = 0})
      : type = MsgArgType.int32,
        value = v;

  MsgArg.boolean({bool v = false})
      : type = MsgArgType.boolean,
        value = v;

  MsgArg.text({String v = ''})
      : type = MsgArgType.text,
        value = v;

  Map<String, dynamic> toWire() {
    switch (type) {
      case MsgArgType.float:
        final lo = min ?? 0.0;
        final hi = max ?? 1.0;
        final dv = (value as double).clamp(lo, hi);
        return {
          'type': 'float',
          'value': dv,
          if (min != null) 'min': lo,
          if (max != null) 'max': hi,
        };
      case MsgArgType.int32:
        return {'type': 'int', 'value': value as int};
      case MsgArgType.boolean:
        return {'type': 'bool', 'value': value as bool};
      case MsgArgType.text:
        return {'type': 'string', 'value': value as String};
    }
  }
}

class OscMessagePanelState extends State<OscMessagePanel>
    with OscMessagePanelActions, OscMessagePanelView {
  // enabled is true by default
  bool enabled = true;

  /// baseAddress に連結する相対（suffix）
  String suffix = '/v1';
  late final TextEditingController addrCtl = TextEditingController(text: suffix);

  /// 追加引数（初期状態で float ひとつ）
  final List<MsgArg> args = [
    MsgArg.float(v: 0.5, min: 0.0, max: 1.0),
  ];

  /// base + suffix を結合した完全アドレス
  String get fullAddress => _joinAddress(widget.baseAddress, suffix);

  @override
  void initState() {
    super.initState();
    // 初期suffix（初期値）を反映
    suffix = widget.initialSuffix;
    addrCtl.text = suffix;

    // 画面が構築された直後に1回、ネイティブへ登録（連続送信ワーカーが拾えるように）
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // _pushMessage は mixin 側の private なので直接呼べないため、
        // public API を通してすべてのフィールドを1回送る。
        await _osc_ubct.invokeMethod('osc.updateMessage', buildWireMessage());
        debugPrint('[osc] init push: ${buildWireMessage()}');
      } catch (e) {
        debugPrint('[osc] init push failed: $e');
      }
    });
  }

  @override
  void dispose() {
    addrCtl.dispose();
    super.dispose();
  }

  // suffix の正規化と反映
  void _saveSuffixFromController() {
    final s = addrCtl.text.trim();
    suffix = s.isEmpty ? '/' : (s.startsWith('/') ? s : '/$s');
    setState(() {});
  }

  // ネイティブに渡すメッセージ定義（完全アドレスも同梱）
  Map<String, dynamic> buildWireMessage() {
    return {
      'id': widget.messageId,
      'enabled': enabled,
      'address': fullAddress, // 連結後
      'suffix': suffix,       // 参考情報
      'args': args.map((e) => e.toWire()).toList(),
    };
  }

  // アドレス結合ユーティリティ
  String _joinAddress(String base, String child) {
    String b = base.trim(), c = child.trim();
    if (!b.startsWith('/')) b = '/$b';
    if (!c.startsWith('/')) c = '/$c';
    final joined = ('$b$c').replaceAll(RegExp(r'/{2,}'), '/');
    return joined.isEmpty ? '/' : joined;
  }

  @override
  Widget build(BuildContext context) => buildOscMessagePanel(context);
}
