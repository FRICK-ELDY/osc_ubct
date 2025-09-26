//! summary: メッセージ送信行（[有効] [ (default +) アドレス ] [送信] ＋ 引数拡張）
//! path: example/lib/ui/osc_message_panel/osc_message_panel.dart

library ui.osc_message_panel;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/info_card.dart';

part 'osc_message_panel_state.dart';
part 'osc_message_panel_actions.dart';
part 'osc_message_panel_view.dart';

/// 既存の MethodChannel に合わせる
const MethodChannel _osc_ubct = MethodChannel('osc_ubct');

class OscMessagePanel extends StatefulWidget {
  /// 送信設定の「デフォルトOSCアドレス」を渡す（例: '/ubct'）
  const OscMessagePanel({
    super.key,
    required this.baseAddress,
    required this.messageId,            // ← 追加：一意ID
    this.initialSuffix = '/v1',        // ← 追加：初期suffix（例：/v1/face/expr/fun にも可）
  });

  final String baseAddress;
  final String messageId;
  final String initialSuffix;

  @override
  State<OscMessagePanel> createState() => OscMessagePanelState();
}
