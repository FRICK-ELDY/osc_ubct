//! summary: ファサード実装（Coreの Worker/Settings/Transport を使用）
//! path: windows/osc/osc_sender.cpp
#include "osc_sender.hpp"

#include <atomic>
#include <iostream>

#include "core/sender_settings.hpp"
#include "core/osc_transport.hpp"
#include "core/sender_worker.hpp"

namespace osc_ubct::osc {

  // Facade 側は「起動中かどうか」だけ手元で保持（デモ関数用）
  static std::atomic<bool> g_enabled{false};

  void EnableOSCSending(bool enable) {
    if (enable) {
      core::StartWorker();
      g_enabled.store(true, std::memory_order_release);
      std::cout << "[OSC] Sending enabled" << std::endl;
    } else {
      core::StopWorker();
      g_enabled.store(false, std::memory_order_release);
      std::cout << "[OSC] Sending disabled" << std::endl;
    }
  }

  void ApplySettingsFromFlutter(const EncodableMap& args) {
    core::ApplySettingsFromFlutter(args);
    core::NudgeWorker(); // 設定変更を即時反映（起床）
  }

  const SenderSettings& GetSenderSettings() {
    return core::GetSenderSettings();
  }

  void SendOSCMessageIfEnabled() {
    if (!g_enabled.load(std::memory_order_acquire)) return;
    const auto& s = core::GetSenderSettings();
    core::SendSimple(s, s.defaultAddress);
  }

} // namespace osc_ubct::osc
