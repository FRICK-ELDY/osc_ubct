//! summary: HomePage の操作ロジック（カメラ追加/削除、ログ表示切替、OpenGL起動等）
//! path: example/lib/ui/home_page/home_page_actions.dart

part of ui.home_page;

/// View から呼ばれる操作の“約束”
abstract class _HomePageAPI {
}

mixin HomePageActions on State<HomePage> implements _HomePageAPI {
}
