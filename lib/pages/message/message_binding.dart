import 'package:daystodieutils/pages/message/message_controller.dart';
import 'package:get/get.dart';


class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessageController());
  }
}