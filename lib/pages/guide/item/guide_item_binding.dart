import 'package:daystodieutils/pages/guide/item/guide_item_controller.dart';
import 'package:get/get.dart';

class GuideItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuideItemController());
  }
}
