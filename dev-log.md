## GitHubのリポジトリ作成
```
git clone osc_ubtc
cd osc_ubtc
```

## FlutterとRustのつなぎ込み
```
cargo install flutter_rust_bridge_codegen
```

## Flutterプラグイン雛形作成
```
flutter upgrade
flutter create --template=plugin --platforms=windows,linux,macos,android,ios .
```
動作確認
```
flutter pub get
cd example
flutter pub get
flutter run -d windows
```

## Rust プラグイン
```
cd example
flutter_rust_bridge_codegen integrate
flutter_rust_bridge_codegen generate --watch
```
動作確認
```
flutter run -d windows
```
