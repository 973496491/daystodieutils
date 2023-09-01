import 'package:get/get.dart';

import 'guide_zombie_controller.dart';

class GuideZombieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuideZombieController());
  }
}
