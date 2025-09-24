// summary: 最小限のOSCエンコード（/path ,type... + args）
// path: example/lib/services/osc/osc_encoder.dart
import 'dart:typed_data';

Uint8List buildOscMessage(String address, String typeTags, List<num> args) {
  // address と typeTags は 4バイト境界にヌル埋め
  final addrBytes = _oscString(address);
  final typeBytes = _oscString(',$typeTags'); // 先頭にカンマ

  // 引数（今回は f=Float32 想定）
  final argBytes = BytesBuilder();
  for (int i = 0; i < typeTags.length; i++) {
    final t = typeTags[i];
    if (t == 'f') {
      final bd = ByteData(4);
      bd.setFloat32(0, (args[i]).toDouble(), Endian.big); // OSCはBE
      argBytes.add(bd.buffer.asUint8List());
    } else {
      throw UnsupportedError('type $t not supported in this minimal encoder');
    }
  }

  final builder = BytesBuilder();
  builder.add(addrBytes);
  builder.add(typeBytes);
  builder.add(argBytes.toBytes());
  return builder.toBytes();
}

Uint8List _oscString(String s) {
  final bytes = Uint8List.fromList(s.codeUnits);
  // 末尾に 0x00、さらに 4の倍数バイト長になるまで 0x00 でパディング
  final padLen = 4 - ((bytes.length + 1) % 4);
  final out = BytesBuilder();
  out.add(bytes);
  out.add(Uint8List(1)); // NUL
  if (padLen != 4) out.add(Uint8List(padLen));
  return out.toBytes();
}
