import 'package:get/get.dart';

import 'service_item_list_controller.dart';

class ServiceItemListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceItemListController());
  }
}
