import 'package:daystodieutils/pages/whitelist/whitelist_controller.dart';
import 'package:get/get.dart';

class WhitelistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WhitelistController());
  }
}
