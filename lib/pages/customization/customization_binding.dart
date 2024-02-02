import 'package:get/get.dart';

import 'customization_controller.dart';

class CustomizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomizationController());
  }
}
