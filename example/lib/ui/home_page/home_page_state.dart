//! summary: HomePage の状態（コントローラ群・ログ表示状態など）
//! path: example/lib/ui/home_page/home_page_state.dart

part of ui.home_page;

class HomePageState extends State<HomePage> with HomePageActions, HomePageView {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => buildHomePage(context);
}
