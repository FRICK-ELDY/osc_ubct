//! summary: 送信ワーカースレッド実装（最小：defaultAddress を rateLimitHz で送信）
//! path: windows/osc/core/sender_worker.cpp
#include "sender_worker.hpp"

#include <atomic>
#include <chrono>
#include <condition_variable>
#include <mutex>
#include <thread>
#include <algorithm>

#include "sender_settings.hpp"
#include "osc_transport.hpp"

namespace osc_ubct::osc::core {

  using Clock = std::chrono::steady_clock;

  // 実行状態
  static std::atomic<bool> g_running{false};
  static std::atomic<bool> g_stop{false};

  // 同期
  static std::thread              g_thread;
  static std::mutex               g_cv_mu;
  static std::condition_variable  g_cv;

  static void WorkerLoop() {
    while (!g_stop.load(std::memory_order_acquire)) {

      // 設定スナップショット
      const auto& s = GetSenderSettings();
      const bool cont = s.sendContinuously;
      const double hz = std::clamp(s.rateLimitHz, 1.0, 240.0);

      if (!cont) {
        // 連続送信OFFなら、ONになる/停止要求まで待機
        std::unique_lock lk(g_cv_mu);
        g_cv.wait(lk, []{
          return g_stop.load();
        });
        continue;
      }

      const auto start = Clock::now();

      // 既定アドレスにダミー値 42 を送る
      SendSimple(s, s.defaultAddress);

      // 次の周期まで待機（停止要求で早期起床）
      const auto period = std::chrono::duration<double>(1.0 / hz);
      std::unique_lock lk(g_cv_mu);
      g_cv.wait_until(
        lk,
        start + std::chrono::duration_cast<Clock::duration>(period),
        []{
          return g_stop.load();
        }
      );
    }
  }

  void StartWorker() {
    if (g_running.load(std::memory_order_acquire)) return;
    g_stop.store(false, std::memory_order_release);
    g_running.store(true, std::memory_order_release);
    g_thread = std::thread(WorkerLoop);
  }

  void StopWorker() {
    if (!g_running.load(std::memory_order_acquire)) return;
    g_stop.store(true, std::memory_order_release);
    g_cv.notify_all();
    if (g_thread.joinable()) g_thread.join();
    g_running.store(false, std::memory_order_release);
  }

  void NudgeWorker() {
    // 設定変更をすぐ反映したい場合の起床（連続OFF時の起床は Stop/Start を併用想定）
    g_cv.notify_all();
  }

} // namespace osc_ubct::osc::core
