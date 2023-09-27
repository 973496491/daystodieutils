import 'package:get/get.dart';

import 'join_service_detail_controller.dart';

class JoinServiceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JoinServiceDetailController());
  }
}
