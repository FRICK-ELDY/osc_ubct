//! summary: HomePage 親（library名方式で state / actions / view を分離）
//! path: example/lib/ui/home_page/home_page.dart

library ui.home_page;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import '../../controllers/camera/camera_controller.dart';
// import '../main_panel/main_panel.dart';

part 'home_page_state.dart';
part 'home_page_actions.dart';
part 'home_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}
