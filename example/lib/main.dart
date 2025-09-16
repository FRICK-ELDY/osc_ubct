//! summary: デスクトップで 9:19.5 の縦長ウィンドウに整える（window_manager 版）
//! path: example/lib/main.dart

import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'ui/root/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // デスクトップのみウィンドウ制御
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    // 9:19.5 の縦長（幅420を基準）
    const baseW = 420.0;
    const baseH = baseW * (19.5 / 9.0); // = 910.0

    final options = WindowOptions(
      size: const Size(baseW, baseH),
      minimumSize: const Size(baseW, baseH),
      center: true,
      backgroundColor: Colors.transparent,
    );

    await windowManager.waitUntilReadyToShow(options, () async {
      // 縦長のアスペクト比を維持（9:19.5）
      await windowManager.setAspectRatio(9 / 19.5);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upper-Body Tracking Controller (UI only)',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const RootPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
