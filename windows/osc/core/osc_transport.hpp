//! summary: UDP/OSC送信 実体（シンプル版）
//! path: windows/osc/core/osc_transport.hpp
#pragma once

#include <string>
#include "sender_settings.hpp"

namespace osc_ubct::osc::core {

// 既定の 42 を 1個載せて、address に送信（成功/失敗を返す）
bool SendSimple(const SenderSettings& s, const std::string& address);

} // namespace osc_ubct::osc::core
