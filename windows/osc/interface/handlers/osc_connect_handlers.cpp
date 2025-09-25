#include "osc_connect_handlers.hpp"
#include "../../osc_sender.hpp"

namespace osc_ubct::osc::connect {
  void StartSending(MethodResultValue result) {
    osc::EnableOSCSending(true);
    result->Success();
    return;
  }

  void StopSending(MethodResultValue result) {
    osc::EnableOSCSending(false);
    result->Success();
    return;
  }
}  // namespace osc_ubct
