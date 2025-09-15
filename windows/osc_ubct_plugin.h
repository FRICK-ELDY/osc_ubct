#ifndef FLUTTER_PLUGIN_OSC_UBCT_PLUGIN_H_
#define FLUTTER_PLUGIN_OSC_UBCT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace osc_ubct {

class OscUbctPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  OscUbctPlugin();

  virtual ~OscUbctPlugin();

  // Disallow copy and assign.
  OscUbctPlugin(const OscUbctPlugin&) = delete;
  OscUbctPlugin& operator=(const OscUbctPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace osc_ubct

#endif  // FLUTTER_PLUGIN_OSC_UBCT_PLUGIN_H_
