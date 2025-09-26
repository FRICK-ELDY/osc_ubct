//! summary: 送信設定の保持・適用・正規化（内部実装）
//! path: windows/osc/core/sender_settings.hpp
#pragma once

#include <string>
#include "interface/handlers/common.hpp"

namespace osc_ubct::osc {
  // 公開型と整合させる（Facade と同一定義）
  struct SenderSettings {
    std::string host;
    int         port;
    std::string defaultAddress;
    bool        sendContinuously;
    double      rateLimitHz;
  };
}

namespace osc_ubct::osc::core {

// Flutter からの設定を反映（型差異や正規化もここで吸収）
void ApplySettingsFromFlutter(const EncodableMap& args);

// 現在の設定（スレッド安全: 参照は読み取り専用で使用）
const SenderSettings& GetSenderSettings();

} // namespace osc_ubct::osc::core
