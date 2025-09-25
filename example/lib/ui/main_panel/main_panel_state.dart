//! summary: MainPanel の State（ローカル状態は持たず、処理/描画は mixin に委譲）
//! path: example/lib/ui/main_panel/main_panel_state.dart

part of ui.main_panel;

class MainPanelState extends State<MainPanel> with MainPanelActions, MainPanelView {
  @override
  Widget build(BuildContext context) => buildMainPanel(context);
}
