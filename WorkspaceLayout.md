# Workspace Layout

- Generated: 2025-09-25 16:21:20
- Root: `D:\Work\FRICK-ELDY\osc_ubct`
- Max Depth: none
- Excludes: `.dart_tool, .git, .github, .gitignore, .idea, .metadata, .vscode, CHANGELOG.md, LICENSE, README.md, WorkspaceLayout.md, analysis_options.yaml, android, assets, bin, build, dev-log.md, dist, docs, ios, linux, macos, node_modules, out, pubspec.lock, pubspec.yaml, rust_builder, target, test, thirdparty, web, xtask`

### Legend
- 0–4: ⚪ (無評価)
- 5–50: 🟢 (OK, 保持)
- 51–100: 🟡 (様子見, 早めに分割候補)
- 101–200: 🟠 (分割推奨)
- 200–: 🔴 (最優先で分割)

## Summaries

### Dart - Flutter UI
| Path | Lines | Status | Summary |
|------|------:|:------:|---------|
| [example/lib/main.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/main.dart) | 16 | 🟢 | アプリのエントリポイント。runApp と最初のルーティング/DI を定義。 |
| [example/lib/ui/common/info_card.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/common/info_card.dart) | 52 | 🟡 | パネル枠の共通UI（タイトル/余白/カード風スタイル）を提供。 |
| [example/lib/ui/home_page/home_page.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page.dart) | 20 | 🟢 | HomePage 親（library名方式で state / actions / view を分離） |
| [example/lib/ui/home_page/home_page_actions.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page_actions.dart) | 11 | 🟢 | HomePage の操作ロジック（カメラ追加/削除、ログ表示切替、OpenGL起動等） |
| [example/lib/ui/home_page/home_page_state.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page_state.dart) | 19 | 🟢 | HomePage の状態（コントローラ群・ログ表示状態など） |
| [example/lib/ui/home_page/home_page_view.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page_view.dart) | 25 | 🟢 | HomePage の UI 構築（Scaffold/メニュー/メイン&ログパネル配置） |
| [example/lib/ui/main_panel/main_panel.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/main_panel/main_panel.dart) | 24 | 🟢 | MainPanel 親（library名方式で state / actions / view を分離） |
| [example/lib/ui/main_panel/main_panel_actions.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/main_panel/main_panel_actions.dart) | 14 | 🟢 | MainPanel の操作系（外部コールバックを安全にラップ） |
| [example/lib/ui/main_panel/main_panel_state.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/main_panel/main_panel_state.dart) | 9 | 🟢 | MainPanel の State（ローカル状態は持たず、処理/描画は mixin に委譲） |
| [example/lib/ui/main_panel/main_panel_view.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/main_panel/main_panel_view.dart) | 27 | 🟢 | MainPanel の UI（OSC送信パネル） |
| [example/lib/ui/osc_sender_panel/osc_sender_panel.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/osc_sender_panel/osc_sender_panel.dart) | 23 | 🟢 | テスト用OSC送信パネル（library名方式で state / actions / view を分離） |
| [example/lib/ui/osc_sender_panel/osc_sender_panel_actions.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/osc_sender_panel/osc_sender_panel_actions.dart) | 25 | 🟢 | 送信ON/OFFトグルなどの操作ロジック（MethodChannel連携） |
| [example/lib/ui/osc_sender_panel/osc_sender_panel_state.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/osc_sender_panel/osc_sender_panel_state.dart) | 12 | 🟢 | 送信ON/OFF状態などの State。本体は mixin に委譲。 |
| [example/lib/ui/osc_sender_panel/osc_sender_panel_view.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/osc_sender_panel/osc_sender_panel_view.dart) | 27 | 🟢 | UI構築（InfoCard／スイッチのみのシンプルビュー） |

---

### Flutter x Cpp Lib
| Path | Lines | Status | Summary |
|------|------:|:------:|---------|
| [lib/osc_ubct.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/lib/osc_ubct.dart) | 8 | 🟢 | (no summary) |
| [lib/osc_ubct_method_channel.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/lib/osc_ubct_method_channel.dart) | 17 | 🟢 | (no summary) |
| [lib/osc_ubct_platform_interface.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/lib/osc_ubct_platform_interface.dart) | 29 | 🟢 | (no summary) |
| [lib/osc_ubct_web.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/lib/osc_ubct_web.dart) | 26 | 🟢 | (no summary) |

---

### Windows - Camera, Tracking, Osc API 
| Path | Lines | Status | Summary |
|------|------:|:------:|---------|
| [windows/include/osc_ubct/osc_ubct_plugin_c_api.h](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/include/osc_ubct/osc_ubct_plugin_c_api.h) | 23 | 🟢 | (no summary) |
| [windows/osc/interface/handlers/common.hpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc/interface/handlers/common.hpp) | 10 | 🟢 | (no summary) |
| [windows/osc/interface/handlers/osc_connect_handlers.cpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc/interface/handlers/osc_connect_handlers.cpp) | 16 | 🟢 | (no summary) |
| [windows/osc/interface/handlers/osc_connect_handlers.hpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc/interface/handlers/osc_connect_handlers.hpp) | 10 | 🟢 | (no summary) |
| [windows/osc/osc_sender.cpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc/osc_sender.cpp) | 27 | 🟢 | (no summary) |
| [windows/osc/osc_sender.hpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc/osc_sender.hpp) | 8 | 🟢 | (no summary) |
| [windows/osc_ubct_plugin.cpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc_ubct_plugin.cpp) | 57 | 🟡 | (no summary) |
| [windows/osc_ubct_plugin.h](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc_ubct_plugin.h) | 36 | 🟢 | (no summary) |
| [windows/osc_ubct_plugin_c_api.cpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc_ubct_plugin_c_api.cpp) | 12 | 🟢 | (no summary) |

## Directory / File Tree

```
root/
├─ .gitmodules
├─ example/
│  ├─ integration_test/
│  │  └─ plugin_integration_test.dart
│  ├─ lib/
│  │  ├─ main.dart — アプリのエントリポイント。runApp と最初のルーティング/DI を定義。
│  │  └─ ui/
│  │     ├─ common/
│  │     │  └─ info_card.dart — パネル枠の共通UI（タイトル/余白/カード風スタイル）を提供。
│  │     ├─ home_page/
│  │     │  ├─ home_page.dart — HomePage 親（library名方式で state / actions / view を分離）
│  │     │  ├─ home_page_actions.dart — HomePage の操作ロジック（カメラ追加/削除、ログ表示切替、OpenGL起動等）
│  │     │  ├─ home_page_state.dart — HomePage の状態（コントローラ群・ログ表示状態など）
│  │     │  └─ home_page_view.dart — HomePage の UI 構築（Scaffold/メニュー/メイン&ログパネル配置）
│  │     ├─ main_panel/
│  │     │  ├─ main_panel.dart — MainPanel 親（library名方式で state / actions / view を分離）
│  │     │  ├─ main_panel_actions.dart — MainPanel の操作系（外部コールバックを安全にラップ）
│  │     │  ├─ main_panel_state.dart — MainPanel の State（ローカル状態は持たず、処理/描画は mixin に委譲）
│  │     │  └─ main_panel_view.dart — MainPanel の UI（OSC送信パネル）
│  │     └─ osc_sender_panel/
│  │        ├─ osc_sender_panel.dart — テスト用OSC送信パネル（library名方式で state / actions / view を分離）
│  │        ├─ osc_sender_panel_actions.dart — 送信ON/OFFトグルなどの操作ロジック（MethodChannel連携）
│  │        ├─ osc_sender_panel_state.dart — 送信ON/OFF状態などの State。本体は mixin に委譲。
│  │        └─ osc_sender_panel_view.dart — UI構築（InfoCard／スイッチのみのシンプルビュー）
│  └─ windows/
│     ├─ CMakeLists.txt
│     ├─ flutter/
│     │  └─ CMakeLists.txt
│     └─ runner/
│        ├─ CMakeLists.txt
│        ├─ Runner.rc
│        ├─ flutter_window.cpp
│        ├─ flutter_window.h
│        ├─ main.cpp
│        ├─ resource.h
│        ├─ resources/
│        │  └─ app_icon.ico
│        ├─ runner.exe.manifest
│        ├─ utils.cpp
│        ├─ utils.h
│        ├─ win32_window.cpp
│        └─ win32_window.h
├─ lib/
│  ├─ osc_ubct.dart
│  ├─ osc_ubct_method_channel.dart
│  ├─ osc_ubct_platform_interface.dart
│  └─ osc_ubct_web.dart
└─ windows/
   ├─ CMakeLists.txt
   ├─ include/
   │  └─ osc_ubct/
   │     └─ osc_ubct_plugin_c_api.h
   ├─ osc/
   │  ├─ CMakeLists.txt
   │  ├─ interface/
   │  │  └─ handlers/
   │  │     ├─ common.hpp
   │  │     ├─ osc_connect_handlers.cpp
   │  │     └─ osc_connect_handlers.hpp
   │  ├─ osc_sender.cpp
   │  └─ osc_sender.hpp
   ├─ osc_ubct_plugin.cpp
   ├─ osc_ubct_plugin.h
   └─ osc_ubct_plugin_c_api.cpp
```

