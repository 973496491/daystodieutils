import 'package:get/get.dart';

import 'join_service_controller.dart';

class JoinServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JoinServiceController());
  }
}
