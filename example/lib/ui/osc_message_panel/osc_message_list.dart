//! summary: 複数メッセージ行の管理（追加/削除）
//! path: example/lib/ui/osc_message_panel/osc_message_list.dart

import 'package:flutter/material.dart';
import 'osc_message_panel.dart';

class OscMessageList extends StatefulWidget {
  const OscMessageList({super.key, required this.baseAddress});
  final String baseAddress; // 例: '/ubct'

  @override
  State<OscMessageList> createState() => _OscMessageListState();
}

class _OscMessageListState extends State<OscMessageList> {
  int _seq = 1;
  final List<_MsgItem> _items = [];

  @override
  void initState() {
    super.initState();
    // 初期行：/v1/face/expr/fun を1つ
    _items.add(_MsgItem(
      id: 'msg-${_seq++}',
      initialSuffix: '/v1/face/expr/fun',
    ));
  }

  void _addItem({String initialSuffix = '/v1'}) {
    setState(() {
      _items.add(_MsgItem(id: 'msg-${_seq++}', initialSuffix: initialSuffix));
    });
  }

  void _removeItem(String id) {
    setState(() {
      _items.removeWhere((e) => e.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ヘッダ行（追加ボタン）
        Row(
          children: [
            const Text('送信メッセージ'),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => _addItem(initialSuffix: '/v1/face/expr/fun'),
              icon: const Icon(Icons.add),
              label: const Text('メッセージを追加'),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // メッセージ行リスト
        for (final m in _items) ...[
          Row(
            children: [
              Text('ID: ${m.id}', style: const TextStyle(color: Colors.grey)),
              const Spacer(),
              IconButton(
                tooltip: 'このメッセージ行を削除',
                onPressed: () => _removeItem(m.id),
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
          OscMessagePanel(
            key: ValueKey(m.id),
            baseAddress: widget.baseAddress,
            messageId: m.id,
            initialSuffix: m.initialSuffix,
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _MsgItem {
  _MsgItem({required this.id, required this.initialSuffix});
  final String id;
  final String initialSuffix;
}
