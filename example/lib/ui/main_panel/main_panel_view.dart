//! summary: MainPanel の UI（OSC送信パネル）
//! path: example/lib/ui/main_panel/main_panel_view.dart

part of ui.main_panel;

mixin MainPanelView on State<MainPanel>, _MainPanelAPI {
  Widget buildMainPanel(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: const [
                OscSenderPanel(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
