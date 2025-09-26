#include "osc_connect_handlers.hpp"

#include <cstdint>
#include <iostream>
#include <string>
#include <variant>
#include <vector>

#include "../../core/sender_settings.hpp"
#include "../../core/sender_worker.hpp"
#include "../../core/osc_transport.hpp"
#include "../../core/message_store.hpp"

namespace osc_ubct::osc::connect {

using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;

using osc_ubct::osc::core::SenderSettings;
using osc_ubct::osc::core::GetSenderSettings;
using osc_ubct::osc::core::ApplySettingsFromFlutter;

using osc_ubct::osc::core::OscArg;
using osc_ubct::osc::core::SendSimple;
using osc_ubct::osc::core::SendWithArgs;

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

void UpdateSettings(const EncodableMap& args, MethodResultValue result) {
  ApplySettingsFromFlutter(args);
  osc_ubct::osc::core::NudgeWorker();
  std::cout << "[OSC] UpdateSettings applied" << std::endl;
  result->Success();
}

void StartSending(MethodResultValue result) {
  std::cout << "[OSC] StartSending" << std::endl;
  osc_ubct::osc::core::StartWorker();
  result->Success();
}

void StopSending(MethodResultValue result) {
  std::cout << "[OSC] StopSending" << std::endl;
  osc_ubct::osc::core::StopWorker();
  result->Success();
}

void UpdateMessage(const EncodableMap& args, MethodResultValue result) {
  const auto* id   = get_if_map<std::string>(args, "id");
  const auto* addr = get_if_map<std::string>(args, "address");
  const auto* list = get_if_map<EncodableList>(args, "args");
  const int argc = (list ? static_cast<int>(list->size()) : 0);
  std::cout << "[OSC] updateMessage: id=" << (id ? *id : "(none)")
            << " addr=" << (addr ? *addr : "(none)")
            << " argc=" << argc << std::endl;

  // store into message store so worker can send it continuously
  osc_ubct::osc::core::UpdateMessageFromFlutter(args);
  // wake worker so it picks up immediately
  osc_ubct::osc::core::NudgeWorker();

  result->Success();
}

void SendMessageNow(const EncodableMap& args, MethodResultValue result) {
  const SenderSettings& s = GetSenderSettings();

  const auto* addr = get_if_map<std::string>(args, "address");
  if (!addr || addr->empty()) {
    result->Error("invalid_arguments", "address missing");
    return;
  }

  const auto* list = get_if_map<EncodableList>(args, "args");
  std::vector<OscArg> argv;
  if (list) argv = parse_args(*list);

  std::cout << "[OSC] SendMessageNow: calling core::SendWithArgs to "
            << s.host << ":" << s.port
            << " addr=" << *addr
            << " argc=" << argv.size()
            << std::endl;

  const bool ok = argv.empty()
    ? SendSimple(s, *addr)
    : SendWithArgs(s, *addr, argv);

  if (ok) {
    result->Success();
  } else {
    result->Error("send_failed", "osc send failed");
  }
}

}  // namespace osc_ubct::osc::connect
