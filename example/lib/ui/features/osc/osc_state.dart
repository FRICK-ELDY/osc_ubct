//! summary: OSCのUI状態。テキストフィールドコントローラと簡易バリデーション
//! path: example/lib/ui/features/osc/osc_state.dart

import 'package:flutter/material.dart';

class OscState {
  final ipCtl = TextEditingController(text: '127.0.0.1');
  final portCtl = TextEditingController(text: '9000');

  bool oscSending = false; // 送信ON/OFF
  int oscTick = 0;         // 簡易カウンタ（実送信数の正確な値ではない）

  // 便利ゲッター
  String get ip => ipCtl.text.trim();
  int? get port => int.tryParse(portCtl.text);

  bool get isValidPort => port != null && port! > 0 && port! <= 65535;
  bool get isValidIp => ip.isNotEmpty; // ここではホスト名も許可

  void dispose() {
    ipCtl.dispose();
    portCtl.dispose();
  }
}
