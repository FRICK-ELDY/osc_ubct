#include "sender_worker.hpp"

#include <atomic>
#include <chrono>
#include <condition_variable>
#include <mutex>
#include <thread>
#include <algorithm>
#include <iostream>

#include "sender_settings.hpp"
#include "message_store.hpp"
#include "osc_transport.hpp"

namespace osc_ubct::osc::core {

using Clock = std::chrono::steady_clock;

static std::atomic<bool> g_running{false};
static std::atomic<bool> g_stop{false};

static std::thread              g_thread;
static std::mutex               g_cv_mu;
static std::condition_variable  g_cv;

static void WorkerLoop() {
  while (!g_stop.load(std::memory_order_acquire)) {

    const auto& s = GetSenderSettings();
    const bool cont = s.sendContinuously;
    const double hz = std::clamp(s.rateLimitHz, 1.0, 240.0);

    if (!cont) {
      std::unique_lock lk(g_cv_mu);
      g_cv.wait(lk, []{ return g_stop.load(); });
      continue;
    }

    const auto start = Clock::now();

    // fetch enabled messages once per tick
    auto msgs = GetActiveMessagesSnapshot();

    if (!msgs.empty()) {
      std::cout << "[OSC] Worker tick: sending " << msgs.size() << " messages" << std::endl;
      for (const auto& m : msgs) {
        if (m.args.empty()) {
          SendSimple(s, m.address);
        } else {
          SendWithArgs(s, m.address, m.args);
        }
      }
    } else {
      // fallback: default address (dummy payload)
      SendSimple(s, s.defaultAddress);
    }

    const auto period = std::chrono::duration<double>(1.0 / hz);
    std::unique_lock lk(g_cv_mu);
    g_cv.wait_until(
      lk,
      start + std::chrono::duration_cast<Clock::duration>(period),
      []{ return g_stop.load(); }
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
  g_cv.notify_all();
}

} // namespace osc_ubct::osc::core
