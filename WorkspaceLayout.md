# Workspace Layout

- Generated: 2025-09-16 23:57:59
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
| [example/lib/main.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/main.dart) | 17 | 🟢 | (no summary) |
| [example/lib/src/rust/api/camera.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/api/camera.dart) | 50 | 🟢 | (no summary) |
| [example/lib/src/rust/api/osc.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/api/osc.dart) | 25 | 🟢 | (no summary) |
| [example/lib/src/rust/api/tracking.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/api/tracking.dart) | 18 | 🟢 | (no summary) |
| [example/lib/src/rust/frb_generated.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.dart) | 977 | 🔴 | (no summary) |
| [example/lib/src/rust/frb_generated.io.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.io.dart) | 433 | 🔴 | (no summary) |
| [example/lib/src/rust/frb_generated.web.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.web.dart) | 409 | 🔴 | (no summary) |
| [example/lib/ui/ubct_preview.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/ui/ubct_preview.dart) | 105 | 🟠 | (no summary) |

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
│  │  ├─ main.dart
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
│  │     └─ ubct_preview.dart
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

