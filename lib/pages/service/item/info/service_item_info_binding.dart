import 'package:get/get.dart';

import 'service_item_info_controller.dart';

class ServiceItemInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceItemInfoController());
  }
}