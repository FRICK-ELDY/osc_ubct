#include "osc_ubct_plugin.h"

#include <windows.h>
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <unordered_map>

#include "osc/interface/handlers/osc_connect_handlers.hpp"

namespace osc_ubct {
  using flutter::EncodableValue;
  using flutter::EncodableMap;

  // static
  void OscUbctPlugin::RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar) {
    auto channel = std::make_unique<flutter::MethodChannel<EncodableValue>>(
        registrar->messenger(), "osc_ubct", &flutter::StandardMethodCodec::GetInstance());
    auto plugin = std::make_unique<OscUbctPlugin>();
    channel->SetMethodCallHandler([plugin_pointer = plugin.get()](const auto &call, auto result) {
      plugin_pointer->HandleMethodCall(call, std::move(result));
    });
    registrar->AddPlugin(std::move(plugin));
  }

  OscUbctPlugin::OscUbctPlugin() {}
  OscUbctPlugin::~OscUbctPlugin() {}

  OscUbctPlugin::Method OscUbctPlugin::GetMethodEnum(const std::string& method_name) {
    static const std::unordered_map<std::string, Method> method_map = {
      {"osc.updateSettings", Method::kUpdateSettings},
      {"osc.startSending",   Method::kStartSending},
      {"osc.stopSending",    Method::kStopSending},
      {"osc.updateMessage",  Method::kUpdateMessage}, 
      {"osc.sendMessageNow",    Method::kSendMessageNow},
    };
    auto it = method_map.find(method_name);
    return it != method_map.end() ? it->second : Method::kUnknown;
  }

  void OscUbctPlugin::HandleMethodCall(const flutter::MethodCall<EncodableValue> &call,
                                       MethodResultValue result) {
    Method method = GetMethodEnum(call.method_name());
    const auto* args = std::get_if<EncodableMap>(call.arguments());
    switch (method) {
      case Method::kUpdateSettings:
        if (args) osc::connect::UpdateSettings(*args, std::move(result));
        else result->Error("invalid_arguments", "args missing");
        break;
      case Method::kStartSending:
        osc::connect::StartSending(std::move(result));
        break;
      case Method::kStopSending:
        osc::connect::StopSending(std::move(result));
        break;
      case Method::kUpdateMessage:
        if (args) osc::connect::UpdateMessage(*args, std::move(result));
        else result->Error("invalid_arguments", "args missing");
        break;
      case Method::kSendMessageNow:
        if (args) osc::connect::SendMessageNow(*args, std::move(result));
        else result->Error("invalid_arguments", "args missing");
        break;
      default:
        result->NotImplemented();
        break;
    }
  }
}  // namespace osc_ubct
