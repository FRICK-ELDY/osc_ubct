//! summary: Actions（有効／アドレス／引数編集・送信をMethodChannelと連動）
//! path: example/lib/ui/osc_message_panel/osc_message_panel_actions.dart

part of ui.osc_message_panel;

abstract class _OscMessageAPI {
  Future<void> toggleEnabled(bool v);
  Future<void> changeSuffix(String s);
  Future<void> sendOnce();

  void addArg(MsgArgType type);
  void removeArgAt(int index);
  void changeArgType(int index, MsgArgType type);
  void changeArgValue(int index, dynamic value);
  void changeArgRange(int index, {double? min, double? max});
}

mixin OscMessagePanelActions on State<OscMessagePanel>
    implements _OscMessageAPI {
  OscMessagePanelState get _st => this as OscMessagePanelState;

  Future<void> _invoke(String method, [Map<String, dynamic>? args]) async {
    try {
      await _osc_ubct.invokeMethod(method, args ?? const {});
    } catch (e) {
      debugPrint('[osc] "$method" failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OSCエラー: $method')),
        );
      }
    }
  }

  Future<void> _pushMessage() async {
    await _invoke('osc.updateMessage', _st.buildWireMessage());
  }

  @override
  Future<void> toggleEnabled(bool v) async {
    setState(() => _st.enabled = v);
    await _pushMessage();
  }

  @override
  Future<void> changeSuffix(String s) async {
    // ★ 入力中は controller を書き換えない（1文字しか入らない問題の原因）
    final raw = s.trim();
    final normalized = raw.isEmpty ? '/' : (raw.startsWith('/') ? raw : '/$raw');

    setState(() {
      _st.suffix = normalized; // 表示は onEditingComplete 側で同期（任意実装）
    });

    await _pushMessage();
  }

  @override
  Future<void> sendOnce() async {
    // 単発送信：連結済みアドレスで即送信
    await _invoke('osc.sendMessage', _st.buildWireMessage());
  }

  // ===== 引数操作 =====

  @override
  void addArg(MsgArgType type) {
    switch (type) {
      case MsgArgType.float:
        _st.args.add(MsgArg.float(v: 0.5, min: 0.0, max: 1.0));
        break;
      case MsgArgType.int32:
        _st.args.add(MsgArg.int32(v: 0));
        break;
      case MsgArgType.boolean:
        _st.args.add(MsgArg.boolean(v: false));
        break;
      case MsgArgType.text:
        _st.args.add(MsgArg.text(v: ''));
        break;
    }
    setState(() {});
    _pushMessage();
  }

  @override
  void removeArgAt(int index) {
    if (index < 0 || index >= _st.args.length) return;
    _st.args.removeAt(index);
    setState(() {});
    _pushMessage();
  }

  @override
  void changeArgType(int index, MsgArgType type) {
    if (index < 0 || index >= _st.args.length) return;
    switch (type) {
      case MsgArgType.float:
        _st.args[index] = MsgArg.float(v: 0.5, min: 0.0, max: 1.0);
        break;
      case MsgArgType.int32:
        _st.args[index] = MsgArg.int32(v: 0);
        break;
      case MsgArgType.boolean:
        _st.args[index] = MsgArg.boolean(v: false);
        break;
      case MsgArgType.text:
        _st.args[index] = MsgArg.text(v: '');
        break;
    }
    setState(() {});
    _pushMessage();
  }

  @override
  void changeArgValue(int index, dynamic value) {
    if (index < 0 || index >= _st.args.length) return;
    final arg = _st.args[index];
    switch (arg.type) {
      case MsgArgType.float:
        final lo = arg.min ?? 0.0;
        final hi = arg.max ?? 1.0;
        arg.value = (value as double).clamp(lo, hi);
        break;
      case MsgArgType.int32:
        arg.value = value as int;
        break;
      case MsgArgType.boolean:
        arg.value = value as bool;
        break;
      case MsgArgType.text:
        arg.value = value as String;
        break;
    }
    setState(() {});
    _pushMessage();
  }

  @override
  void changeArgRange(int index, {double? min, double? max}) {
    if (index < 0 || index >= _st.args.length) return;
    final arg = _st.args[index];
    if (arg.type != MsgArgType.float) return;

    if (min != null) arg.min = min;
    if (max != null) arg.max = max;

    // 範囲更新に合わせて値をクランプ
    final lo = arg.min ?? 0.0;
    final hi = arg.max ?? 1.0;
    arg.value = (arg.value as double).clamp(lo, hi);

    setState(() {});
    _pushMessage();
  }
}
