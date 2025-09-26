#include "message_store.hpp"

#include <mutex>
#include <iostream>

namespace osc_ubct::osc::core {

using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;

static std::unordered_map<std::string, StoredMessage> g_msgs;
static std::mutex g_mu;

template<typename T>
static const T* get_if_map(const EncodableMap& m, const char* key) {
  auto it = m.find(EncodableValue(key));
  if (it == m.end()) return nullptr;
  return std::get_if<T>(&it->second);
}

static std::vector<OscArg> parse_args(const EncodableList& in) {
  std::vector<OscArg> out;
  out.reserve(in.size());
  for (const auto& v : in) {
    const auto* m = std::get_if<EncodableMap>(&v);
    if (!m) continue;

    const auto* t = get_if_map<std::string>(*m, "type");
    if (!t) continue;

    if (*t == "float") {
      float fv = 0.0f;
      if (const auto* pd = get_if_map<double>(*m, "value")) fv = static_cast<float>(*pd);
      else if (const auto* pi64 = get_if_map<int64_t>(*m, "value")) fv = static_cast<float>(*pi64);
      else if (const auto* pi32 = get_if_map<int32_t>(*m, "value")) fv = static_cast<float>(*pi32);
      else if (const auto* pi = get_if_map<int>(*m, "value")) fv = static_cast<float>(*pi);
      OscArg a{}; a.type = OscArg::Type::Float; a.f = fv;
      out.push_back(a);

    } else if (*t == "int") {
      int iv = 0;
      if (const auto* pi64 = get_if_map<int64_t>(*m, "value")) iv = static_cast<int>(*pi64);
      else if (const auto* pi32 = get_if_map<int32_t>(*m, "value")) iv = static_cast<int>(*pi32);
      else if (const auto* pd = get_if_map<double>(*m, "value")) iv = static_cast<int>(*pd);
      else if (const auto* pi = get_if_map<int>(*m, "value")) iv = *pi;
      OscArg a{}; a.type = OscArg::Type::Int; a.i = iv;
      out.push_back(a);

    } else if (*t == "bool") {
      bool bv = false;
      if (const auto* pb = get_if_map<bool>(*m, "value")) bv = *pb;
      OscArg a{}; a.type = OscArg::Type::Bool; a.b = bv;
      out.push_back(a);

    } else if (*t == "string") {
      std::string sv;
      if (const auto* ps = get_if_map<std::string>(*m, "value")) sv = *ps;
      OscArg a{}; a.type = OscArg::Type::String; a.s = std::move(sv);
      out.push_back(std::move(a));
    }
  }
  return out;
}

void UpdateMessageFromFlutter(const EncodableMap& args) {
  const auto* pid   = get_if_map<std::string>(args, "id");
  if (!pid) {
    std::cout << "[OSC] updateMessage: missing id -> ignored" << std::endl;
    return;
  }
  const auto* pen   = get_if_map<bool>(args, "enabled");
  const auto* paddr = get_if_map<std::string>(args, "address");
  const auto* pargs = get_if_map<EncodableList>(args, "args");

  StoredMessage m;
  m.id = *pid;
  m.enabled = pen ? *pen : false;
  m.address = paddr ? *paddr : std::string{};
  if (pargs) m.args = parse_args(*pargs);

  {
    std::lock_guard<std::mutex> lk(g_mu);
    g_msgs[m.id] = std::move(m);
  }

  std::cout << "[OSC] MessageStore upsert: id=" << *pid
            << " enabled=" << (pen && *pen ? "true":"false")
            << " addr=" << (paddr ? *paddr : "(none)")
            << std::endl;
}

std::vector<StoredMessage> GetActiveMessagesSnapshot() {
  std::vector<StoredMessage> out;
  std::lock_guard<std::mutex> lk(g_mu);
  out.reserve(g_msgs.size());
  for (const auto& kv : g_msgs) {
    const auto& m = kv.second;
    if (!m.enabled) continue;
    if (m.address.empty()) continue;
    out.push_back(m);
  }
  return out;
}

void RemoveMessageById(const std::string& id) {
  std::lock_guard<std::mutex> lk(g_mu);
  g_msgs.erase(id);
}

} // namespace osc_ubct::osc::core
