import 'package:get/get.dart';

import 'zombie_list_controller.dart';

class ZombieListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ZombieListController());
  }
}
