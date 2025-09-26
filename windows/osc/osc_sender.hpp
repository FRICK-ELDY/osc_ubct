//! summary: ファサード（公開API; 構造体は core 側の定義を利用）
//! path: windows/osc/osc_sender.hpp
#pragma once

#include <string>
#include "interface/handlers/common.hpp"
#include "core/sender_settings.hpp"

namespace osc_ubct::osc {

// 送信 ON/OFF（true: 有効 / false: 無効）
void EnableOSCSending(bool enable);

// enable時のみ defaultAddress に 1回送信（デモ）
void SendOSCMessageIfEnabled();

// Flutter から渡された設定を適用
void ApplySettingsFromFlutter(const EncodableMap& args);

// 現在の設定を取得（coreの実体をそのまま返す）
const SenderSettings& GetSenderSettings();

} // namespace osc_ubct::osc
