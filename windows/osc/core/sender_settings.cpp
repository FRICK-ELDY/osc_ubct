//! summary: 設定の保持・適用・正規化（実装）
//! path: windows/osc/core/sender_settings.cpp
#include "sender_settings.hpp"

#include <algorithm>
#include <cstdint>
#include <mutex>
#include <iostream>
#include <flutter/standard_method_codec.h>

namespace osc_ubct::osc::core {

  using flutter::EncodableMap;
  using flutter::EncodableValue;

  static SenderSettings g_settings{
    "127.0.0.1", 9000, "/ubct", true, 60.0
  };
  static std::mutex g_mu;

  static std::string normalize_addr(std::string a) {
    if (a.empty()) a = "/";
    if (a.front() != '/') a.insert(a.begin(), '/');
    for (size_t pos = 0; (pos = a.find("//", pos)) != std::string::npos; )
      a.erase(pos, 1);
    return a;
  }

  template<typename T>
  static const T* get_if_map(const EncodableMap& m, const char* key) {
    auto it = m.find(EncodableValue(key));
    if (it == m.end()) return nullptr;
    return std::get_if<T>(&it->second);
  }

  void ApplySettingsFromFlutter(const EncodableMap& args) {
    std::lock_guard<std::mutex> lk(g_mu);

    // host
    if (const auto* s = get_if_map<std::string>(args, "host")) {
      if (!s->empty()) g_settings.host = *s;
    }

    // port（int64_t / int32_t / int に対応）
    if (const auto* p64 = get_if_map<int64_t>(args, "port")) {
      g_settings.port = static_cast<int>(*p64);
    } else if (const auto* p32 = get_if_map<int32_t>(args, "port")) {
      g_settings.port = static_cast<int>(*p32);
    } else if (const auto* pi = get_if_map<int>(args, "port")) {
      g_settings.port = *pi;
    }

    // defaultAddress 正規化
    if (const auto* a = get_if_map<std::string>(args, "defaultAddress")) {
      g_settings.defaultAddress = normalize_addr(*a);
    }

    // sendContinuously
    if (const auto* b = get_if_map<bool>(args, "sendContinuously")) {
      g_settings.sendContinuously = *b;
    }

    // rateLimitHz（1〜240; int/double 対応）
    if (const auto* hz_d = get_if_map<double>(args, "rateLimitHz")) {
      g_settings.rateLimitHz = std::clamp(*hz_d, 1.0, 240.0);
    } else if (const auto* hz_i64 = get_if_map<int64_t>(args, "rateLimitHz")) {
      g_settings.rateLimitHz = std::clamp(static_cast<double>(*hz_i64), 1.0, 240.0);
    } else if (const auto* hz_i32 = get_if_map<int32_t>(args, "rateLimitHz")) {
      g_settings.rateLimitHz = std::clamp(static_cast<double>(*hz_i32), 1.0, 240.0);
    } else if (const auto* hz_i = get_if_map<int>(args, "rateLimitHz")) {
      g_settings.rateLimitHz = std::clamp(static_cast<double>(*hz_i), 1.0, 240.0);
    }

    if (g_settings.host.empty()) g_settings.host = "127.0.0.1";

    std::cout << "[OSC] Settings updated: "
              << g_settings.host << ":" << g_settings.port
              << " addr=" << g_settings.defaultAddress
              << " cont=" << (g_settings.sendContinuously ? "true" : "false")
              << " hz=" << g_settings.rateLimitHz
              << std::endl;
  }

  const SenderSettings& GetSenderSettings() {
    return g_settings;
  }

} // namespace osc_ubct::osc::core
