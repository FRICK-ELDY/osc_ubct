## GitHubのリポジトリ作成
```
git clone osc_ubtc
cd osc_ubtc
```
## Flutterプラグイン雛形作成
```
flutter upgrade
flutter create --template=plugin --org com.example --platforms=windows,linux,macos,android,ios,web -i swift -a kotlin .
```
動作確認
```
flutter pub get
cd example
flutter pub get
flutter run -d windows    # Windows
flutter run -d macos      # macOS
flutter run -d linux      # Linux
flutter run -d android    # Android
flutter run -d ios        # iOS
flutter run -d chrome     # Web
```
