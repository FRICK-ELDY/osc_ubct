#pragma once

#include "interface/handlers/common.hpp"

namespace osc_ubct::osc {
void EnableOSCSending(bool enable); 
void SendOSCMessageIfEnabled();
// Flutterから渡された設定を適用する
void ApplySettingsFromFlutter(const EncodableMap& args);

// 内部的に保持している設定を取得したい場合用
struct SenderSettings {
  std::string host;
  int port;
  std::string defaultAddress;
  bool sendContinuously;
  double rateLimitHz;
};
const SenderSettings& GetSenderSettings();

}
