//! summary: View（上段1行：[toggle] [ (default +) アドレス ] [送信]／下段：引数編集UI）
//! path: example/lib/ui/osc_message_panel/osc_message_panel_view.dart

part of ui.osc_message_panel;

mixin OscMessagePanelView on State<OscMessagePanel>, _OscMessageAPI {
  Widget buildOscMessagePanel(BuildContext context) {
    final st = this as OscMessagePanelState;

    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === 上段 1行： [toggle(有効/無効)] [text((default +) osc address)] [button(send)] ===
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              // [toggle(有効/無効)]
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('有効'),
                  Switch(
                    value: st.enabled,
                    onChanged: toggleEnabled,
                  ),
                ],
              ),

              // [text((default +) osc address)]
              // 入力は suffix（右側 helper に full を表示）
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 300, maxWidth: 480),
                child: TextField(
                  controller: st.addrCtl,
                  decoration: InputDecoration(
                    labelText: 'OSCアドレス（suffix）',
                    hintText: '/v1/face/expr/fun',
                    prefixIcon: const Icon(Icons.route),
                    helperText: '送信先: ${st.fullAddress}',
                    helperMaxLines: 1,
                  ),
                  onChanged: changeSuffix,
                ),
              ),

              // [button(send)]
              FilledButton.icon(
                onPressed: sendOnce,
                icon: const Icon(Icons.send),
                label: const Text('送信'),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),

          // === 下段：引数エディタ ===
          Row(
            children: [
              const Text('追加引数'),
              const SizedBox(width: 8),
              _AddArgMenu(onAdd: addArg),
            ],
          ),
          const SizedBox(height: 8),
          _ArgList(
            args: st.args,
            onTypeChanged: changeArgType,
            onValueChanged: changeArgValue,
            onRangeChanged: changeArgRange,
            onRemove: removeArgAt,
          ),
        ],
      ),
    );
  }
}

/// 引数追加メニュー（MenuAnchor使用）
class _AddArgMenu extends StatelessWidget {
  final void Function(MsgArgType) onAdd;
  const _AddArgMenu({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, _) => OutlinedButton.icon(
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        icon: const Icon(Icons.add),
        label: const Text('引数を追加'),
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () => onAdd(MsgArgType.float),
          child: const Text('float'),
        ),
        MenuItemButton(
          onPressed: () => onAdd(MsgArgType.int32),
          child: const Text('int'),
        ),
        MenuItemButton(
          onPressed: () => onAdd(MsgArgType.boolean),
          child: const Text('bool'),
        ),
        MenuItemButton(
          onPressed: () => onAdd(MsgArgType.text),
          child: const Text('string'),
        ),
      ],
    );
  }
}

/// 追加引数リスト（各行を Row + Align(left) で確実に左詰め）
class _ArgList extends StatelessWidget {
  final List<MsgArg> args;
  final void Function(int, MsgArgType) onTypeChanged;
  final void Function(int, dynamic) onValueChanged;
  final void Function(int, {double? min, double? max}) onRangeChanged;
  final void Function(int) onRemove;

  const _ArgList({
    required this.args,
    required this.onTypeChanged,
    required this.onValueChanged,
    required this.onRangeChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (args.isEmpty) return const Text('（追加引数なし）');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(args.length, (i) {
        final a = args[i];

        // ——— 型ごとのエディタ（左詰め） ———
        Widget editor;
        switch (a.type) {
          case MsgArgType.float:
            editor = Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // min
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    initialValue: (a.min ?? 0.0).toStringAsFixed(2),
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(labelText: 'min'),
                    keyboardType: TextInputType.number,
                    onChanged: (s) =>
                        onRangeChanged(i, min: double.tryParse(s)),
                  ),
                ),
                const SizedBox(width: 12),
                // max
                SizedBox(
                  width: 120,
                  child: TextFormField(
                    initialValue: (a.max ?? 1.0).toStringAsFixed(2),
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(labelText: 'max'),
                    keyboardType: TextInputType.number,
                    onChanged: (s) =>
                        onRangeChanged(i, max: double.tryParse(s)),
                  ),
                ),
                const SizedBox(width: 12),
                // value（スライダ）
                SizedBox(
                  width: 280,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('value: ${(a.value as double).toStringAsFixed(2)}'),
                      Slider(
                        value: (a.value as double)
                            .clamp(a.min ?? 0.0, a.max ?? 1.0),
                        min: a.min ?? 0.0,
                        max: a.max ?? 1.0,
                        onChanged: (v) => onValueChanged(i, v),
                      ),
                    ],
                  ),
                ),
              ],
            );
            break;

          case MsgArgType.int32:
            editor = SizedBox(
              width: 220,
              child: TextFormField(
                initialValue: '${a.value}',
                textAlign: TextAlign.left,
                decoration: const InputDecoration(labelText: 'int'),
                keyboardType: TextInputType.number,
                onChanged: (s) => onValueChanged(i, int.tryParse(s) ?? 0),
              ),
            );
            break;

          case MsgArgType.boolean:
            editor = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('false'),
                Switch(
                  value: a.value as bool,
                  onChanged: (v) => onValueChanged(i, v),
                ),
                const Text('true'),
              ],
            );
            break;

          case MsgArgType.text:
            editor = SizedBox(
              width: 320,
              child: TextFormField(
                initialValue: a.value as String,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(labelText: 'string'),
                onChanged: (s) => onValueChanged(i, s),
              ),
            );
            break;
        }

        // ——— 1引数行：強制左寄せ（Row + Align） ———
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min, // 子の幅のみ
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButton<MsgArgType>(
                  value: a.type,
                  onChanged: (t) => onTypeChanged(i, t ?? a.type),
                  items: const [
                    DropdownMenuItem(
                        value: MsgArgType.float, child: Text('float')),
                    DropdownMenuItem(
                        value: MsgArgType.int32, child: Text('int')),
                    DropdownMenuItem(
                        value: MsgArgType.boolean, child: Text('bool')),
                    DropdownMenuItem(
                        value: MsgArgType.text, child: Text('string')),
                  ],
                ),
                const SizedBox(width: 12),
                editor,
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () => onRemove(i),
                  icon: const Icon(Icons.delete_outline),
                  tooltip: '削除',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
