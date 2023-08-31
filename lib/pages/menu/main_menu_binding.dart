import 'package:daystodieutils/pages/menu/main_menu_controller.dart';
import 'package:get/get.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainMenuController());
  }
}