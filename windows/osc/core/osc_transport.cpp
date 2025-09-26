//! summary: UDP/OSC 送信の実体（単純な1メッセージ送信）
//! path: windows/osc/core/osc_transport.cpp
#include "osc_transport.hpp"

#include "osc/OscOutboundPacketStream.h"
#include "ip/UdpSocket.h"

#include <cstring>

namespace osc_ubct::osc::core {

  static std::string normalize_addr(std::string a) {
    if (a.empty()) a = "/";
    if (a.front() != '/') a.insert(a.begin(), '/');
    for (size_t pos = 0; (pos = a.find("//", pos)) != std::string::npos; )
      a.erase(pos, 1);
    return a;
  }

  bool SendSimple(const SenderSettings& s, const std::string& address) {
    const std::string addr = normalize_addr(address);
    if (addr.empty()) return false;

    UdpTransmitSocket socket(IpEndpointName(s.host.c_str(), s.port));

    char buffer[1024];
    ::osc::OutboundPacketStream p(buffer, sizeof(buffer));
    try {
      p << ::osc::BeginMessage(addr.c_str())
        << 42 // ダミー値
        << ::osc::EndMessage;
      socket.Send(p.Data(), p.Size());
      return true;
    } catch (...) {
      return false;
    }
  }

} // namespace osc_ubct::osc::core
