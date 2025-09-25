//! summary: アプリのエントリポイント。runApp と最初のルーティング/DI を定義。
//! path: example/lib/main.dart

import 'package:flutter/material.dart';
import 'ui/home_page/home_page.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
