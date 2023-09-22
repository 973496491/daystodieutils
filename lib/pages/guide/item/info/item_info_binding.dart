import 'package:daystodieutils/pages/guide/item/info/item_info_controller.dart';
import 'package:get/get.dart';

class ItemInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemInfoController());
  }
}