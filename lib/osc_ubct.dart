
import 'osc_ubct_platform_interface.dart';

class OscUbct {
  Future<String?> getPlatformVersion() {
    return OscUbctPlatform.instance.getPlatformVersion();
  }
}
