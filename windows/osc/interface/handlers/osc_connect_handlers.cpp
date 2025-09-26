//! path: windows/osc/interface/handlers/osc_connect_handlers.cpp
#include "osc_connect_handlers.hpp"
#include "../../osc_sender.hpp"

namespace osc_ubct::osc::connect {
  void UpdateSettings(const EncodableMap& args, MethodResultValue result) {
    osc::ApplySettingsFromFlutter(args);
    result->Success();
  }

  void StartSending(MethodResultValue result) {
    osc::EnableOSCSending(true);
    result->Success();
  }

  void StopSending(MethodResultValue result) {
    osc::EnableOSCSending(false);
    result->Success();
  }
}  // namespace osc_ubct::osc::connect
