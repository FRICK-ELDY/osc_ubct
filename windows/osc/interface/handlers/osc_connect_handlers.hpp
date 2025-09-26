//! path: windows/osc/interface/handlers/osc_connect_handlers.hpp
#pragma once

#include "common.hpp"

namespace osc_ubct::osc {
  namespace connect {
    void UpdateSettings(const EncodableMap& args, MethodResultValue result);
    void StartSending(MethodResultValue result);
    void StopSending(MethodResultValue result);
    void UpdateMessage(const EncodableMap& args, MethodResultValue result);
    void SendMessageNow(const EncodableMap& args, MethodResultValue result);
  }
}
