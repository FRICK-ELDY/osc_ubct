//! summary: ファサード（公開API; スレッド管理は core に委譲）
//! path: windows/osc/osc_sender.hpp
#pragma once

#include <string>
#include "interface/handlers/common.hpp"
#include "core/sender_settings.hpp"

namespace osc_ubct::osc {

// 送信 ON/OFF（true: ワーカースレッド起動 / false: 停止）
void EnableOSCSending(bool enable);

// enable時のみ defaultAddress に 1回送信（デモ）
void SendOSCMessageIfEnabled();

// Flutter から渡された設定を適用（即時反映させるためにワーカーを起床）
void ApplySettingsFromFlutter(const EncodableMap& args);

// 現在の設定を取得（coreの実体をそのまま返す）
const SenderSettings& GetSenderSettings();

} // namespace osc_ubct::osc
