//! path: windows/osc/osc_sender.cpp
#include "osc_sender.hpp"

#include "./core/sender_settings.hpp"
#include "./core/sender_worker.hpp"

#include <iostream>

namespace osc_ubct::osc {

  void ApplySettingsFromFlutter(const EncodableMap& args) {
    core::ApplySettingsFromFlutter(args);
    core::NudgeWorker();
  }

  void EnableOSCSending(bool enable) {
    if (enable) {
      core::StartWorker();
      std::cout << "[OSC] Sending enabled" << std::endl;
    } else {
      core::StopWorker();
      std::cout << "[OSC] Sending disabled" << std::endl;
    }
  }

} // namespace osc_ubct::osc
