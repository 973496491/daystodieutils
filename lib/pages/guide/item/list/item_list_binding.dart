import 'package:daystodieutils/pages/guide/item/list/item_list_controller.dart';
import 'package:get/get.dart';

class ItemListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ItemListController());
  }
}
