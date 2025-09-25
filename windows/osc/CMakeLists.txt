cmake_minimum_required(VERSION 3.14)
project(osc_lib LANGUAGES CXX)

# ライブラリ本体（最小構成）
add_library(osc_lib STATIC)

# --- あなたの実装ソース（必要最小限） ---
file(GLOB OSC_CPP            "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
file(GLOB OSC_HANDLERS_CPP   "${CMAKE_CURRENT_SOURCE_DIR}/interface/handlers/*.cpp")
target_sources(osc_lib PRIVATE ${OSC_CPP} ${OSC_HANDLERS_CPP})

# --- oscpack を同梱ビルド（固定パス：windows/thirdparty/oscpack） ---
# 例: windows/thirdparty/oscpack/osc/OscOutboundPacketStream.cpp
set(OSCPACK_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../thirdparty/oscpack")
file(GLOB OSCPACK_OSC_CPP   "${OSCPACK_ROOT}/osc/*.cpp")
file(GLOB OSCPACK_IP_CPP    "${OSCPACK_ROOT}/ip/*.cpp")
file(GLOB OSCPACK_WIN_CPP   "${OSCPACK_ROOT}/ip/win32/*.cpp")

target_sources(osc_lib PRIVATE
  ${OSCPACK_OSC_CPP}
  ${OSCPACK_IP_CPP}
  ${OSCPACK_WIN_CPP}
)

# --- インクルードパス ---
#   - あなたのヘッダ: windows/osc
#   - oscpack のヘッダルート: windows/thirdparty/oscpack
#     （これで #include "osc/OscOutboundPacketStream.h" が通ります）
target_include_directories(osc_lib PUBLIC
  "${CMAKE_CURRENT_SOURCE_DIR}"
  "${OSCPACK_ROOT}"
)

# Flutter のヘッダ（common.hpp から "flutter/method_channel.h" を使うため）
# 上位（example）の CMake で定義される FLUTTER_MANAGED_DIR をそのまま参照。
# 未定義でもエラーにせず、見つかれば使うだけ。
if(DEFINED FLUTTER_MANAGED_DIR)
  target_include_directories(osc_lib PRIVATE
    "${FLUTTER_MANAGED_DIR}"
    "${FLUTTER_MANAGED_DIR}/cpp_client_wrapper/include"
  )
endif()

# C++17 / MSVC オプション（最小）
target_compile_features(osc_lib PUBLIC cxx_std_17)
if (MSVC)
  target_compile_options(osc_lib PRIVATE /Zc:__cplusplus)
endif()

# リンク（oscpack が使用する Windows 系のみ）
# timeGetTime -> winmm, ソケット -> ws2_32
# PUBLIC にしておくことで、osc_lib を利用する側へも伝播させます。
target_link_libraries(osc_lib PUBLIC
  ws2_32
  winmm
)

# サードパーティ由来の警告を抑制（必要なら）
if (MSVC)
  target_compile_definitions(osc_lib PRIVATE _CRT_SECURE_NO_WARNINGS _WINSOCK_DEPRECATED_NO_WARNINGS)
  target_compile_options(osc_lib PRIVATE /wd4996)
endif()
