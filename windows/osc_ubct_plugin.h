#ifndef FLUTTER_PLUGIN_OSC_UBCT_PLUGIN_H_
#define FLUTTER_PLUGIN_OSC_UBCT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <memory>

namespace osc_ubct {

using MethodResultValue = std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>;

class OscUbctPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  OscUbctPlugin();
  virtual ~OscUbctPlugin();

  OscUbctPlugin(const OscUbctPlugin&) = delete;
  OscUbctPlugin& operator=(const OscUbctPlugin&) = delete;

  void HandleMethodCall(const flutter::MethodCall<flutter::EncodableValue> &call, MethodResultValue result);

 private:
  enum class Method {
    kUnknown,
    kUpdateSettings,
    kStartSending,
    kStopSending,
    kUpdateMessage,
    kSendMessageNow,
  };

  static Method GetMethodEnum(const std::string& method_name);
};

}  // namespace osc_ubct

#endif  // FLUTTER_PLUGIN_OSC_UBCT_PLUGIN_H_
