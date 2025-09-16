# Workspace Layout

- Generated: 2025-09-16 22:42:05
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
| [example/lib/main.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/main.dart) | 93 | 🟡 | (no summary) |
| [example/lib/src/rust/api/simple.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/api/simple.dart) | 10 | 🟢 | (no summary) |
| [example/lib/src/rust/frb_generated.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.dart) | 242 | 🔴 | (no summary) |
| [example/lib/src/rust/frb_generated.io.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.io.dart) | 86 | 🟡 | (no summary) |
| [example/lib/src/rust/frb_generated.web.dart](https://github.com/FRICK-ELDY/rust-3d/blob/main/example/lib/src/rust/frb_generated.web.dart) | 86 | 🟡 | (no summary) |

---

### Rust - Camera API
| Path | Lines | Status | Summary |
|------|------:|:------:|---------|
| _no files_ | 0 | - | - |

---

### Rust - Tracking API
| Path | Lines | Status | Summary |
|------|------:|:------:|---------|
| _no files_ | 0 | - | - |

---

### Rust - Osc API
| Path | Lines | Status | Summary |
|------|------:|:------:|---------|
| _no files_ | 0 | - | - |

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
│  │  └─ src/
│  │     └─ rust/
│  │        ├─ api/
│  │        │  └─ simple.dart
│  │        ├─ frb_generated.dart
│  │        ├─ frb_generated.io.dart
│  │        └─ frb_generated.web.dart
│  ├─ rust/
│  │  ├─ Cargo.lock
│  │  ├─ Cargo.toml
│  │  └─ src/
│  │     ├─ api/
│  │     │  ├─ mod.rs
│  │     │  └─ simple.rs
│  │     ├─ frb_generated.rs
│  │     └─ lib.rs
│  └─ test_driver/
│     └─ integration_test.dart
└─ lib/
   ├─ osc_ubct.dart
   ├─ osc_ubct_method_channel.dart
   └─ osc_ubct_platform_interface.dart
```

