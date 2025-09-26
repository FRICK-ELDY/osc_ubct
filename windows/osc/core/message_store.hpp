#pragma once
#include <string>
#include <vector>
#include <unordered_map>
#include "interface/handlers/common.hpp"   // EncodableMap / EncodableList / EncodableValue
#include "osc_transport.hpp"               // OscArg

namespace osc_ubct::osc::core {

struct StoredMessage {
  std::string id;
  bool enabled = false;
  std::string address;
  std::vector<OscArg> args;
};

// Upsert from Flutter (id, enabled, address, args[])
void UpdateMessageFromFlutter(const EncodableMap& args);

// Snapshot of all enabled messages
std::vector<StoredMessage> GetActiveMessagesSnapshot();

// (optional) remove by id — not used now
void RemoveMessageById(const std::string& id);

} // namespace osc_ubct::osc::core
