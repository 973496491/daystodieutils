import 'package:daystodieutils/pages/room/add/add_room_controller.dart';
import 'package:get/get.dart';

class AddRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddRoomController());
  }
}
