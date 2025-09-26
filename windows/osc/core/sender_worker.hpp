//! summary: 送信ワーカースレッド（起動/停止/起床）
//! path: windows/osc/core/sender_worker.hpp
#pragma once

namespace osc_ubct::osc::core {

// EnableOSCSending(true) 相当
void StartWorker();

// EnableOSCSending(false) 相当
void StopWorker();

// 設定変更などでワーカーを起床
void NudgeWorker();

} // namespace osc_ubct::osc::core
