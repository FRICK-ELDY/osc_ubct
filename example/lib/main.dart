import 'package:flutter/material.dart';
import 'ui/ubct_preview.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UBCT',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const UbctPreviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
