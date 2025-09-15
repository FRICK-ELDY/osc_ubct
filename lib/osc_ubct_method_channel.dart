import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'osc_ubct_platform_interface.dart';

/// An implementation of [OscUbctPlatform] that uses method channels.
class MethodChannelOscUbct extends OscUbctPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('osc_ubct');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
