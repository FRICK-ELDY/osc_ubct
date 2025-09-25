# Workspace Layout

- Generated: 2025-09-25 13:49:24
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
| [example/lib/ui/home_page/home_page.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page.dart) | 21 | 🟢 | HomePage 親（library名方式で state / actions / view を分離） |
| [example/lib/ui/home_page/home_page_actions.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page_actions.dart) | 11 | 🟢 | HomePage の操作ロジック（カメラ追加/削除、ログ表示切替、OpenGL起動等） |
| [example/lib/ui/home_page/home_page_state.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page_state.dart) | 19 | 🟢 | HomePage の状態（コントローラ群・ログ表示状態など） |
| [example/lib/ui/home_page/home_page_view.dart](https://github.com/FRICK-ELDY/osc_ubct/blob/main/example/lib/ui/home_page/home_page_view.dart) | 20 | 🟢 | HomePage の UI 構築（Scaffold/メニュー/メイン&ログパネル配置） |

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
| [windows/osc_ubct_plugin.cpp](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc_ubct_plugin.cpp) | 59 | 🟡 | (no summary) |
| [windows/osc_ubct_plugin.h](https://github.com/FRICK-ELDY/osc_ubct/blob/main/windows/osc_ubct_plugin.h) | 31 | 🟢 | (no summary) |
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
│  │     └─ home_page/
│  │        ├─ home_page.dart — HomePage 親（library名方式で state / actions / view を分離）
│  │        ├─ home_page_actions.dart — HomePage の操作ロジック（カメラ追加/削除、ログ表示切替、OpenGL起動等）
│  │        ├─ home_page_state.dart — HomePage の状態（コントローラ群・ログ表示状態など）
│  │        └─ home_page_view.dart — HomePage の UI 構築（Scaffold/メニュー/メイン&ログパネル配置）
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
   ├─ osc_ubct_plugin.cpp
   ├─ osc_ubct_plugin.h
   └─ osc_ubct_plugin_c_api.cpp
```

