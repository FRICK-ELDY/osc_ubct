# Workspace Layout

- Generated: 2025-09-17 01:08:35
- Root: `D:\Work\FRICK-ELDY\osc_ubct`
- Max Depth: none
- Excludes: `.dart_tool, .git, .github, .gitignore, .idea, .metadata, .vscode, CHANGELOG.md, LICENSE, README.md, WorkspaceLayout.md, analysis_options.yaml, android, assets, bin, build, dev-log.md, dist, docs, ios, linux, macos, node_modules, out, pubspec.lock, pubspec.yaml, rust_builder, target, test, windows, xtask`

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
| [example/lib/common_view/app_card.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/common_view/app_card.dart) | 21 | 🟢 | カード風のコンテナ（共通見た目） |
| [example/lib/common_view/badge_chip.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/common_view/badge_chip.dart) | 22 | 🟢 | バッジチップ（UI onlyなどの表示） |
| [example/lib/main.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/main.dart) | 49 | 🟢 | デスクトップで 9:19.5 の縦長ウィンドウに整える（window_manager 版） |
| [example/lib/models/euler.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/models/euler.dart) | 7 | 🟢 | Euler角のシンプルなデータクラス |
| [example/lib/services/runtime/osc_runtime.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/services/runtime/osc_runtime.dart) | 37 | 🟢 | FRBを使ったシンプルOSCランタイム。UIからの設定はここに集約、送信はCameraのtickから呼ぶ |
| [example/lib/src/rust/api/camera.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/api/camera.dart) | 50 | 🟢 | (no summary) |
| [example/lib/src/rust/api/osc.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/api/osc.dart) | 25 | 🟢 | (no summary) |
| [example/lib/src/rust/api/tracking.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/api/tracking.dart) | 18 | 🟢 | (no summary) |
| [example/lib/src/rust/frb_generated.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.dart) | 977 | 🔴 | (no summary) |
| [example/lib/src/rust/frb_generated.io.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.io.dart) | 433 | 🔴 | (no summary) |
| [example/lib/src/rust/frb_generated.web.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.web.dart) | 409 | 🔴 | (no summary) |
| [example/lib/ui/features/camera/camera_actions.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/camera/camera_actions.dart) | 218 | 🔴 | FRBに合わせたCamera制御。JPG取得→ui.Image化、JSON→Euler反映、OSC送信はOscRuntimeへ |
| [example/lib/ui/features/camera/camera_state.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/camera/camera_state.dart) | 60 | 🟡 | Cameraの状態（UI用）。joints/Euler 値やプレビュー画像を保持 |
| [example/lib/ui/features/camera/camera_view.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/camera/camera_view.dart) | 230 | 🔴 | Camera UIカード。プレビューの RawImage 表示や各種設定UI |
| [example/lib/ui/features/face/face_actions.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/face/face_actions.dart) | 16 | 🟢 | 顔表情（UIのみ・モック送信） |
| [example/lib/ui/features/face/face_state.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/face/face_state.dart) | 7 | 🟢 | 顔表情のUI状態 |
| [example/lib/ui/features/face/face_view.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/face/face_view.dart) | 48 | 🟢 | 顔表情のUIカード |
| [example/lib/ui/features/osc/osc_actions.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/osc/osc_actions.dart) | 63 | 🟡 | FRB版OSC制御。ターゲット設定＆有効化のみ管理し、送信はOscRuntimeに委譲 |
| [example/lib/ui/features/osc/osc_state.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/osc/osc_state.dart) | 24 | 🟢 | OSCのUI状態。テキストフィールドコントローラと簡易バリデーション |
| [example/lib/ui/features/osc/osc_view.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/osc/osc_view.dart) | 82 | 🟡 | OSCカード。ターゲット設定と送信ON/OFFのUI |
| [example/lib/ui/features/settings/display_settings_sheet.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/features/settings/display_settings_sheet.dart) | 96 | 🟡 | 表示設定ボトムシート（Pull / Preview / Data） |
| [example/lib/ui/root/root_page.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/root/root_page.dart) | 137 | 🟠 | 9:19.5 の縦長パネルに UI をレイアウトするルートページ |

---

### Rust - Camera,Tracking,Osc API 
| Path | Lines | Status | Summary |
|------|------:|:------:|---------|
| [example/rust/src/api/camera.rs](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/rust/src/api/camera.rs) | 39 | 🟢 | (no summary) |
| [example/rust/src/api/mod.rs](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/rust/src/api/mod.rs) | 6 | 🟢 | apiモジュールの集約 |
| [example/rust/src/api/osc.rs](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/rust/src/api/osc.rs) | 26 | 🟢 | (no summary) |
| [example/rust/src/api/tracking.rs](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/rust/src/api/tracking.rs) | 22 | 🟢 | (no summary) |
| [example/rust/src/frb_generated.rs](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/rust/src/frb_generated.rs) | 848 | 🔴 | (no summary) |
| [example/rust/src/lib.rs](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/rust/src/lib.rs) | 8 | 🟢 | FRB v2用 lib.rs（余計なimportを排除） |

## Directory / File Tree

```
root/
├─ example/
│  ├─ flutter_rust_bridge.yaml
│  ├─ integration_test/
│  │  ├─ plugin_integration_test.dart
│  │  └─ simple_test.dart
│  ├─ lib/
│  │  ├─ common_view/
│  │  │  ├─ app_card.dart — カード風のコンテナ（共通見た目）
│  │  │  └─ badge_chip.dart — バッジチップ（UI onlyなどの表示）
│  │  ├─ main.dart — デスクトップで 9:19.5 の縦長ウィンドウに整える（window_manager 版）
│  │  ├─ models/
│  │  │  └─ euler.dart — Euler角のシンプルなデータクラス
│  │  ├─ services/
│  │  │  └─ runtime/
│  │  │     └─ osc_runtime.dart — FRBを使ったシンプルOSCランタイム。UIからの設定はここに集約、送信はCameraのtickから呼ぶ
│  │  ├─ src/
│  │  │  └─ rust/
│  │  │     ├─ api/
│  │  │     │  ├─ camera.dart
│  │  │     │  ├─ osc.dart
│  │  │     │  └─ tracking.dart
│  │  │     ├─ frb_generated.dart
│  │  │     ├─ frb_generated.io.dart
│  │  │     └─ frb_generated.web.dart
│  │  └─ ui/
│  │     ├─ features/
│  │     │  ├─ camera/
│  │     │  │  ├─ camera_actions.dart — FRBに合わせたCamera制御。JPG取得→ui.Image化、JSON→Euler反映、OSC送信はOscRuntimeへ
│  │     │  │  ├─ camera_state.dart — Cameraの状態（UI用）。joints/Euler 値やプレビュー画像を保持
│  │     │  │  └─ camera_view.dart — Camera UIカード。プレビューの RawImage 表示や各種設定UI
│  │     │  ├─ face/
│  │     │  │  ├─ face_actions.dart — 顔表情（UIのみ・モック送信）
│  │     │  │  ├─ face_state.dart — 顔表情のUI状態
│  │     │  │  └─ face_view.dart — 顔表情のUIカード
│  │     │  ├─ osc/
│  │     │  │  ├─ osc_actions.dart — FRB版OSC制御。ターゲット設定＆有効化のみ管理し、送信はOscRuntimeに委譲
│  │     │  │  ├─ osc_state.dart — OSCのUI状態。テキストフィールドコントローラと簡易バリデーション
│  │     │  │  └─ osc_view.dart — OSCカード。ターゲット設定と送信ON/OFFのUI
│  │     │  └─ settings/
│  │     │     └─ display_settings_sheet.dart — 表示設定ボトムシート（Pull / Preview / Data）
│  │     └─ root/
│  │        └─ root_page.dart — 9:19.5 の縦長パネルに UI をレイアウトするルートページ
│  ├─ rust/
│  │  ├─ Cargo.lock
│  │  ├─ Cargo.toml
│  │  └─ src/
│  │     ├─ api/
│  │     │  ├─ camera.rs
│  │     │  ├─ mod.rs — apiモジュールの集約
│  │     │  ├─ osc.rs
│  │     │  └─ tracking.rs
│  │     ├─ frb_generated.rs
│  │     └─ lib.rs — FRB v2用 lib.rs（余計なimportを排除）
│  └─ test_driver/
│     └─ integration_test.dart
└─ lib/
   ├─ osc_ubct.dart
   ├─ osc_ubct_method_channel.dart
   └─ osc_ubct_platform_interface.dart
```

