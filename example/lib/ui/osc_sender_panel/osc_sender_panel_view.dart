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

            // 宛先ホスト/IP
            TextFormField(
              controller: st.hostCtl,
              decoration: const InputDecoration(
                labelText: '宛先ホスト / IP',
                hintText: '127.0.0.1',
                prefixIcon: Icon(Icons.dns),
              ),
              validator: st.validateHost,
            ),
            const SizedBox(height: 12),

            // ポート
            TextFormField(
              controller: st.portCtl,
              decoration: const InputDecoration(
                labelText: 'ポート',
                hintText: '9000',
                prefixIcon: Icon(Icons.numbers),
              ),
              keyboardType: TextInputType.number,
              validator: st.validatePort,
            ),
            const SizedBox(height: 12),

            // デフォルトOSCアドレス
            TextFormField(
              controller: st.addrCtl,
              decoration: const InputDecoration(
                labelText: 'デフォルトOSCアドレス',
                hintText: '/ubct',
                prefixIcon: Icon(Icons.route),
              ),
              validator: st.validateAddress,
            ),
            const SizedBox(height: 12),

            // 連続送信 On/Off ＋ レート
            Row(
              children: [
                Expanded(
                  child: SwitchListTile(
                    title: const Text("連続送信"),
                    value: st.sendContinuously,
                    onChanged: (v) => toggleContinuous(v),
                  ),
                ),
                Expanded(
                  child: Opacity(
                    opacity: st.sendContinuously ? 1 : 0.5,
                    child: Slider(
                      value: st.rateLimitHz.clamp(1, 240),
                      min: 1,
                      max: 240,
                      divisions: 239,
                      label: '${st.rateLimitHz.toStringAsFixed(0)} Hz',
                      onChanged: st.sendContinuously
                          ? (v) => changeRate(v)
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 送信 On/Off
            SwitchListTile(
              title: const Text("送信"),
              value: st.isSending,
              onChanged: toggleSend,
            ),
          ],
        ),
      ),
    );
  }
}
