//! path: windows/osc/osc_sender.hpp
#pragma once
#include "interface/handlers/common.hpp"

namespace osc_ubct::osc {

void ApplySettingsFromFlutter(const EncodableMap& args);
void EnableOSCSending(bool enable);

} // namespace osc_ubct::osc
