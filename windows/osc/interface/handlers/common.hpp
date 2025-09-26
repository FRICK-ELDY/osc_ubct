//! path: windows/osc/interface/handlers/common.hpp
#pragma once

#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <memory>

namespace osc_ubct {
  using MethodResultValue = std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>;
  using EncodableMap = flutter::EncodableMap;
}  // namespace osc_ubct
