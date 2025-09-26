//! summary: ファサード実装（core に委譲）
//! path: windows/osc/osc_sender.cpp
#include "osc_sender.hpp"

#include <atomic>
#include <iostream>

#include "core/sender_settings.hpp"
#include "core/osc_transport.hpp"

namespace osc_ubct::osc {

  static std::atomic<bool> g_send_enabled{false};

  void EnableOSCSending(bool enable) {
    g_send_enabled.store(enable);
    std::cout << "[OSC] Sending " << (enable ? "enabled" : "disabled") << std::endl;
  }

  void ApplySettingsFromFlutter(const EncodableMap& args) {
    core::ApplySettingsFromFlutter(args);
  }

  const SenderSettings& GetSenderSettings() {
    return core::GetSenderSettings();
  }

  void SendOSCMessageIfEnabled() {
    if (!g_send_enabled.load()) return;
    const auto& s = core::GetSenderSettings();
    core::SendSimple(s, s.defaultAddress);
  }

} // namespace osc_ubct::osc
