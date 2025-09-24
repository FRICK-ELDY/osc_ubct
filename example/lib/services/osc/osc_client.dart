// summary: RawDatagramSocketでのUDP送信クライアント
// path: example/lib/services/osc/osc_client.dart
import 'dart:io';
import 'dart:typed_data';

class OscClient {
  OscClient({required this.ip, required this.port});

  String ip;
  int port;
  RawDatagramSocket? _sock;

  Future<void> open() async {
    _sock ??= await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    _sock!.readEventsEnabled = false;
  }

  void close() {
    _sock?.close();
    _sock = null;
  }

  void send(Uint8List bytes) {
    final s = _sock;
    if (s == null) return;
    s.send(bytes, InternetAddress(ip), port);
  }
}
