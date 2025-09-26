#include "osc_sender.hpp"
#include "osc/OscOutboundPacketStream.h"
#include "ip/UdpSocket.h"
#include <iostream>

namespace osc_ubct::osc {

  static bool send_enabled = false;

  static SenderSettings g_settings{
    "127.0.0.1", 9000, "/ubct", true, 60.0
  };

  void EnableOSCSending(bool enable) {
    send_enabled = enable;
    std::cout << "[OSC] Sending " << (enable ? "enabled" : "disabled") << std::endl;
  }

  void ApplySettingsFromFlutter(const EncodableMap& args) {
    // host
    if (auto it = args.find(flutter::EncodableValue("host")); it != args.end()) {
      if (auto p = std::get_if<std::string>(&it->second)) {
        g_settings.host = *p;
      }
    }
    // port
    if (auto it = args.find(flutter::EncodableValue("port")); it != args.end()) {
      if (auto p = std::get_if<int>(&it->second)) {
        g_settings.port = *p;
      }
    }
    // defaultAddress
    if (auto it = args.find(flutter::EncodableValue("defaultAddress")); it != args.end()) {
      if (auto p = std::get_if<std::string>(&it->second)) {
        g_settings.defaultAddress = *p;
      }
    }
    // sendContinuously
    if (auto it = args.find(flutter::EncodableValue("sendContinuously")); it != args.end()) {
      if (auto p = std::get_if<bool>(&it->second)) {
        g_settings.sendContinuously = *p;
      }
    }
    // rateLimitHz
    if (auto it = args.find(flutter::EncodableValue("rateLimitHz")); it != args.end()) {
      if (auto pInt = std::get_if<int>(&it->second)) {
        g_settings.rateLimitHz = static_cast<double>(*pInt);
      } else if (auto pDouble = std::get_if<double>(&it->second)) {
        g_settings.rateLimitHz = *pDouble;
      }
    }

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

  void SendOSCMessageIfEnabled() {
    if (!send_enabled) return;

    UdpTransmitSocket transmitSocket(IpEndpointName(g_settings.host.c_str(), g_settings.port));

    char buffer[1024];
    ::osc::OutboundPacketStream p(buffer, 1024);
    p << ::osc::BeginMessage(g_settings.defaultAddress.c_str()) << 42 << ::osc::EndMessage;

    transmitSocket.Send(p.Data(), p.Size());
  }
}  // namespace osc_ubct::osc
