//! summary: OSCカード。ターゲット設定と送信ON/OFFのUI
//! path: example/lib/ui/features/osc/osc_view.dart

import 'package:flutter/material.dart';
import '../../../common_view/app_card.dart';
import 'osc_state.dart';
import 'osc_actions.dart';

class OscView extends StatelessWidget {
  final OscState state;
  final OscActions actions;
  const OscView({super.key, required this.state, required this.actions});

  @override
  Widget build(BuildContext context) {
    final enabledColor = state.oscSending ? Colors.green : Colors.grey;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // タイトル + ステータス
          Row(
            children: [
              const Text('OSC'),
              const Spacer(),
              Icon(Icons.circle, size: 10, color: enabledColor),
              const SizedBox(width: 6),
              Text(state.oscSending ? 'Enabled' : 'Disabled'),
            ],
          ),
          const SizedBox(height: 8),

          // IP / Port
          Row(children: [
            Expanded(
              child: TextField(
                controller: state.ipCtl,
                decoration: const InputDecoration(
                  labelText: 'Target IP / Host',
                  hintText: '例) 127.0.0.1',
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 120,
              child: TextField(
                controller: state.portCtl,
                decoration: InputDecoration(
                  labelText: 'Port',
                  errorText: state.isValidPort ? null : '1-65535',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ]),
          const SizedBox(height: 12),

          // Enable / Apply
          Row(
            children: [
              FilledButton.icon(
                onPressed: () => actions.toggleOscSending(context),
                icon: Icon(state.oscSending ? Icons.stop : Icons.play_arrow),
                label: Text(state.oscSending ? 'Disable' : 'Enable'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => actions.applyTargetOnly(context),
                icon: const Icon(Icons.check),
                label: const Text('Apply Target'),
              ),
              const Spacer(),
              Text('sent: ${state.oscTick}'),
            ],
          ),
        ],
      ),
    );
  }
}
