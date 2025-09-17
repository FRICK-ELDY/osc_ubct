//! summary: デスクトップで 9:19.5 縦長ウィンドウ & FRB 初期化してから UI 起動
//! path: example/lib/main.dart
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'src/rust/frb_generated.dart' as frb;
import 'ui/root/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await frb.RustLib.init();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    const baseW = 420.0;
    const baseH = baseW * (19.5 / 9.0);

    final options = WindowOptions(
      size: const Size(baseW, baseH),
      minimumSize: const Size(baseW, baseH),
      center: true,
      backgroundColor: Colors.transparent,
    );

    await windowManager.waitUntilReadyToShow(options, () async {
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
