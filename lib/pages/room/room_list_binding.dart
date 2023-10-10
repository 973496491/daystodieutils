import 'package:get/get.dart';

import 'room_list_controller.dart';

class RoomListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoomListController());
  }
}
