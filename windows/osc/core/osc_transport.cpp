#include "osc_transport.hpp"
#include "sender_settings.hpp"

#include "osc/OscOutboundPacketStream.h"
#include "ip/UdpSocket.h"
#include <iostream>

namespace osc_ubct::osc::core {

  static std::string normalize_addr(std::string a) {
    if (a.empty()) a = "/";
    if (a.front() != '/') a.insert(a.begin(), '/');
    for (size_t pos = 0; (pos = a.find("//", pos)) != std::string::npos; )
      a.erase(pos, 1);
    return a;
  }

  static bool SendImpl(const SenderSettings& s, const std::string& addr,
                       const std::vector<OscArg>* args) {
    std::cout << "[OSC] core::SendImpl ENTER addr=" << addr
              << " argc=" << (args ? args->size() : 0) << std::endl;

    const std::string address = normalize_addr(addr);
    if (address.empty()) return false;

    UdpTransmitSocket socket(IpEndpointName(s.host.c_str(), s.port));

    char buffer[2048];
    ::osc::OutboundPacketStream p(buffer, sizeof(buffer));

    try {
      p << ::osc::BeginMessage(address.c_str());
      if (args) {
        for (const auto& a : *args) {
          switch (a.type) {
            case OscArg::Type::Float:  p << a.f; break;
            case OscArg::Type::Int:    p << a.i; break;
            case OscArg::Type::Bool:   p << (a.b ? true : false); break;
            case OscArg::Type::String: p << a.s.c_str(); break;
          }
        }
      } else {
        p << 42; // demo value
      }
      p << ::osc::EndMessage;

      socket.Send(p.Data(), p.Size());

      std::cout << "[OSC] Sent: " << s.host << ":" << s.port
                << " addr=" << address
                << " bytes=" << p.Size()
                << std::endl;
      return true;

    } catch (const std::exception& e) {
      std::cout << "[OSC] Send FAILED: " << s.host << ":" << s.port
                << " addr=" << address
                << " error=" << e.what() << std::endl;
      return false;
    } catch (...) {
      std::cout << "[OSC] Send FAILED (unknown): " << s.host << ":" << s.port
                << " addr=" << address << std::endl;
      return false;
    }
  }

  bool SendSimple(const SenderSettings& s, const std::string& address) {
    return SendImpl(s, address, nullptr);
  }

  bool SendWithArgs(const SenderSettings& s, const std::string& address,
                    const std::vector<OscArg>& args) {
    return SendImpl(s, address, &args);
  }

} // namespace osc_ubct::osc::core
