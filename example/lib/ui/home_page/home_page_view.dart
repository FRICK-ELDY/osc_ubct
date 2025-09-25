//! summary: HomePage の UI 構築（Scaffold/メニュー/メイン&ログパネル配置）
//! path: example/lib/ui/home_page/home_page_view.dart

part of ui.home_page;

mixin HomePageView on State<HomePage>, _HomePageAPI {
  Widget buildHomePage(BuildContext context) {
    final st = this as HomePageState;

    return Scaffold(
      appBar: AppBar(
        title: const Text("osc upper body camera tracking plugin"),
      ),
      body: Column(
        children: [
          Expanded(
            child: MainPanel(
              onUpdate: () => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }
}
