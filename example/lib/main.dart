// summary: 立ち上げたらOSC Senderページを出す
// path: example/lib/main.dart
import 'package:flutter/material.dart';
import 'ui/osc_sender_page.dart';

void main() => runApp(const OscOnlyApp());

class OscOnlyApp extends StatelessWidget {
  const OscOnlyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'osc_ubct | OSC Only',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const OscSenderPage(),
    );
  }
}
