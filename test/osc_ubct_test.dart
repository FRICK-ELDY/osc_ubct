import 'package:flutter_test/flutter_test.dart';
import 'package:osc_ubct/osc_ubct.dart';
import 'package:osc_ubct/osc_ubct_platform_interface.dart';
import 'package:osc_ubct/osc_ubct_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOscUbctPlatform
    with MockPlatformInterfaceMixin
    implements OscUbctPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final OscUbctPlatform initialPlatform = OscUbctPlatform.instance;

  test('$MethodChannelOscUbct is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOscUbct>());
  });

  test('getPlatformVersion', () async {
    OscUbct oscUbctPlugin = OscUbct();
    MockOscUbctPlatform fakePlatform = MockOscUbctPlatform();
    OscUbctPlatform.instance = fakePlatform;

    expect(await oscUbctPlugin.getPlatformVersion(), '42');
  });
}
