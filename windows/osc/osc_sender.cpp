#include "osc_sender.hpp"
#include "osc/OscOutboundPacketStream.h"
#include "ip/UdpSocket.h"
#include <iostream>

namespace osc_ubct::osc {

static bool send_enabled = false;

void EnableOSCSending(bool enable) {
  send_enabled = enable;
  std::cout << "[OSC] Sending " << (enable ? "enabled" : "disabled") << std::endl;
}

void SendOSCMessageIfEnabled() {
  if (!send_enabled) return;

  UdpTransmitSocket transmitSocket(IpEndpointName("127.0.0.1", 9000));

  char buffer[1024];
  ::osc::OutboundPacketStream p(buffer, 1024);
  p << ::osc::BeginMessage("/example") << 42 << ::osc::EndMessage;

  transmitSocket.Send(p.Data(), p.Size());
}

}
