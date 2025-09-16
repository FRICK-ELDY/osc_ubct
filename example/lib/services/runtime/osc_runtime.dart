//! summary: FRBを使ったシンプルOSCランタイム。UIからの設定はここに集約、送信はCameraのtickから呼ぶ
//! path: example/lib/services/runtime/osc_runtime.dart

import 'dart:typed_data';

// FRB 生成コード（相対パスはプロジェクトに合わせてください）
import '../../src/rust/api/osc.dart' as osc_api;

class OscRuntime {
  static String _ip = '127.0.0.1';
  static int _port = 9000;
  static bool _enabled = false;
  static osc_api.OscSender? _sender;

  static Future<void> setTarget(String ip, int port) async {
    _ip = ip; _port = port;
    if (_enabled) {
      // 再接続（軽量のため作り直し）
      _sender = await osc_api.oscOpen(ip: _ip, port: _port);
    }
  }

  static Future<void> setEnabled(bool v) async {
    _enabled = v;
    if (_enabled) {
      _sender ??= await osc_api.oscOpen(ip: _ip, port: _port);
    } else {
      _sender = null; // dropでソケットクローズ
    }
  }

  static Future<void> sendJsonIfEnabled(Uint8List json) async {
    if (!_enabled) return;
    _sender ??= await osc_api.oscOpen(ip: _ip, port: _port);
    await osc_api.oscSendJson(osc: _sender!, path: '/ub/pose', json: json);
  }
}
