import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'osc_ubct_method_channel.dart';

abstract class OscUbctPlatform extends PlatformInterface {
  /// Constructs a OscUbctPlatform.
  OscUbctPlatform() : super(token: _token);

  static final Object _token = Object();

  static OscUbctPlatform _instance = MethodChannelOscUbct();

  /// The default instance of [OscUbctPlatform] to use.
  ///
  /// Defaults to [MethodChannelOscUbct].
  static OscUbctPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OscUbctPlatform] when
  /// they register themselves.
  static set instance(OscUbctPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
