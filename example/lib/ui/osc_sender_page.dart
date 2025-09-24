// summary: VRChat向けに /tracking/trackers/{i}/rotation を送るUI
// path: example/lib/ui/osc_sender_page.dart
import 'package:flutter/material.dart';
import '../services/osc/osc_client.dart';
import '../services/osc/osc_encoder.dart';

class OscSenderPage extends StatefulWidget {
  const OscSenderPage({super.key});

  @override
  State<OscSenderPage> createState() => _OscSenderPageState();
}

class _OscSenderPageState extends State<OscSenderPage> {
  final _ipCtrl = TextEditingController(text: '127.0.0.1');
  final _portCtrl = TextEditingController(text: '9000');
  final _idxCtrl = TextEditingController(text: '1');

  late OscClient _client;
  double _x = 0, _y = 0, _z = 0;
  bool _connected = false;
  bool _autosend = true;

  @override
  void initState() {
    super.initState();
    _client = OscClient(ip: _ipCtrl.text, port: int.parse(_portCtrl.text));
  }

  @override
  void dispose() {
    _client.close();
    _ipCtrl.dispose();
    _portCtrl.dispose();
    _idxCtrl.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    _client.ip = _ipCtrl.text.trim();
    _client.port = int.tryParse(_portCtrl.text.trim()) ?? 9000;
    await _client.open();
    setState(() => _connected = true);
  }

  void _sendRotation() {
    final idx = int.tryParse(_idxCtrl.text.trim()) ?? 1;
    final path = '/tracking/trackers/$idx/rotation';
    final pkt = buildOscMessage(path, 'fff', [_x, _y, _z]);
    _client.send(pkt);
  }

  void _sendHeadZeroOnce() {
    final pkt = buildOscMessage('/tracking/trackers/head/rotation', 'fff', [0, 0, 0]);
    _client.send(pkt);
  }

  Widget _slider(String label, double v, ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(width: 72, child: Text(label)),
        Expanded(
          child: Slider(
            value: v,
            min: -90,
            max: 90,
            divisions: 180,
            label: v.toStringAsFixed(0),
            onChanged: (nv) {
              setState(() => onChanged(nv));
              if (_connected && _autosend) _sendRotation();
            },
          ),
        ),
        SizedBox(width: 48, child: Text(v.toStringAsFixed(0))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sendBtn = FilledButton(
      onPressed: _connected ? _sendRotation : null,
      child: const Text('Send /rotation'),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('OSC Sender (VRChat)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Endpoint'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ipCtrl,
                    decoration: const InputDecoration(labelText: 'IP', hintText: '127.0.0.1'),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _portCtrl,
                    decoration: const InputDecoration(labelText: 'Port'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: _connected ? null : _connect,
                  child: const Text('Connect'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: _idxCtrl,
                    decoration: const InputDecoration(labelText: 'Tracker Index'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _connected ? _sendHeadZeroOnce : null,
                  child: const Text('Head Zero Once'),
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    const Text('Auto-send'),
                    Switch(
                      value: _autosend,
                      onChanged: (v) => setState(() => _autosend = v),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 32),
            const Text('Euler XYZ (degrees)'),
            const SizedBox(height: 8),
            _slider('X (pitch)', _x, (nv) => _x = nv),
            _slider('Y (yaw)  ', _y, (nv) => _y = nv),
            _slider('Z (roll) ', _z, (nv) => _z = nv),
            const SizedBox(height: 16),
            Align(alignment: Alignment.centerLeft, child: sendBtn),
            const SizedBox(height: 24),
            Text(
              'Tips:\n'
              '- VRChat 側で「OSC Enabled」にする\n'
              '- まずは「Head Zero Once」で向き合わせ（ヨー整合）\n'
              '- トラッカーは /tracking/trackers/{index}/rotation へ float×3 を送信',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
