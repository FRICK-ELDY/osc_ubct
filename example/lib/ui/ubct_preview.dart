import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';

// FRBが生成したDartを相対インポート（パスはプロジェクトに合わせて）
import '../src/rust/api/camera.dart' as cam_api;
import '../src/rust/api/tracking.dart' as tr_api;
import '../src/rust/api/osc.dart' as osc_api;

class UbctPreviewPage extends StatefulWidget {
  const UbctPreviewPage({super.key});
  @override
  State<UbctPreviewPage> createState() => _UbctPreviewPageState();
}

class _UbctPreviewPageState extends State<UbctPreviewPage> {
  cam_api.Camera? _cam;
  tr_api.Tracker? _tr;
  osc_api.OscSender? _osc;

  Uint8List? _jpeg;
  bool _sendOsc = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    // カメラ / トラッカー / OSC を起動
    final cam = await cam_api.cameraOpen(index: 0, w: 640, h: 480, fps: 30);
    final tr = await tr_api.trackingInit(modelPath: null);
    final osc = await osc_api.oscOpen(ip: '127.0.0.1', port: 9000);

    setState(() {
      _cam = cam;
      _tr = tr;
      _osc = osc;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 15), _tick);
  }

  Future<void> _tick(Timer _) async {
    if (_cam == null || _tr == null) return;

    final frame = await cam_api.cameraGrabJpeg(cam: _cam!, quality: 80);
    setState(() => _jpeg = frame.jpeg);

    if (_sendOsc && _osc != null) {
      final json = await tr_api.trackingLatestJson(tr: _tr!);
      await osc_api.oscSendJson(osc: _osc!, path: '/ub/pose', json: json);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UBCT (FRB)')),
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.black),
                    child: _jpeg == null
                        ? const Center(child: Text('waiting...', style: TextStyle(color: Colors.white70)))
                        : Image.memory(_jpeg!, gaplessPlayback: true, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  left: 8, right: 8, bottom: 8,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(children: [
                        const Text('OSC'),
                        const SizedBox(width: 8),
                        Switch(value: _sendOsc, onChanged: (v)=>setState(()=>_sendOsc = v)),
                        const Spacer(),
                        Text(_jpeg == null ? '—' : '${_jpeg!.lengthInBytes ~/ 1024} KB'),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
