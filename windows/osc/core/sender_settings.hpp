#pragma once

#include <string>
#include "interface/handlers/common.hpp"

namespace osc_ubct::osc::core {

struct SenderSettings {
  std::string host;
  int         port;
  std::string defaultAddress;
  bool        sendContinuously;
  double      rateLimitHz;
};

void ApplySettingsFromFlutter(const EncodableMap& args);

const SenderSettings& GetSenderSettings();

} // namespace osc_ubct::osc::core

namespace osc_ubct::osc {
  using SenderSettings = core::SenderSettings;
}
