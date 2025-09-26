//! summary: UI構築（フォーム＋送信On/Off）
//! path: example/lib/ui/osc_sender_panel/osc_sender_panel_view.dart

part of ui.osc_sender_panel;

mixin OscSenderPanelView on State<OscSenderPanel>, _OscSenderAPI {
  Widget buildOscSenderPanel(BuildContext context) {
    final st = this as OscSenderPanelState;

    return InfoCard(
      child: Form(
        key: st.formKey,
        onChanged: st.saveFormToState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "OSC Sender",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 宛先ホスト/IP
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: st.hostCtl,
                        decoration: const InputDecoration(
                          labelText: '宛先ホスト / IP',
                          hintText: '127.0.0.1',
                          prefixIcon: Icon(Icons.dns),
                        ),
                        validator: st.validateHost,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ポート
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: st.portCtl,
                        decoration: const InputDecoration(
                          labelText: 'ポート',
                          hintText: '9000',
                          prefixIcon: Icon(Icons.numbers),
                        ),
                        keyboardType: TextInputType.number,
                        validator: st.validatePort,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // デフォルトOSCアドレス
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        controller: st.addrCtl,
                        decoration: const InputDecoration(
                          labelText: 'デフォルトOSCアドレス',
                          hintText: '/ubct',
                          prefixIcon: Icon(Icons.route),
                        ),
                        validator: st.validateAddress,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),

            // 連続送信 On/Off ＋ レート（数値表示つき： [toggle] [連続送信] [slider] [xx hz] ）
            Row(
              children: [
                // [toggle(有効)]
                Switch(
                  value: st.sendContinuously,
                  onChanged: (v) => toggleContinuous(v),
                ),
                const SizedBox(width: 8),

                // [text(連続送信)]
                const Text('送信間隔'),

                const SizedBox(width: 16),

                // [slider(1~240)]（無効時は操作不可＆半透明）
                Expanded(
                  child: Opacity(
                    opacity: st.sendContinuously ? 1.0 : 0.5,
                    child: IgnorePointer(
                      ignoring: !st.sendContinuously,
                      child: Slider(
                        value: st.rateLimitHz.clamp(1, 240),
                        min: 1,
                        max: 240,
                        divisions: 239,
                        onChanged: (v) => changeRate(v),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // [text(xx hz)] 右寄せで固定幅
                SizedBox(
                  width: 70,
                  child: Text(
                    '${st.rateLimitHz.toStringAsFixed(0)} hz',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 送信 On/Off（[toggle] [接続/未接続]）
            Row(
              children: [
                // [toggle(無効/有効)]
                Switch(
                  value: st.isSending,
                  onChanged: toggleSend,
                ),
                const SizedBox(width: 8),

                // [text(接続/未接続)]
                Text(
                  st.isSending ? '接続' : '未接続',
                  style: TextStyle(
                    color: st.isSending ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
