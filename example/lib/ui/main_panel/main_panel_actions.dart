//! summary: MainPanel の操作系（外部コールバックを安全にラップ）
//! path: example/lib/ui/main_panel/main_panel_actions.dart

part of ui.main_panel;

/// View から呼ぶ操作の“約束”
abstract class _MainPanelAPI {
  void notifyUpdate();
}

mixin MainPanelActions on State<MainPanel> implements _MainPanelAPI {
  @override
  void notifyUpdate() => widget.onUpdate();
}
