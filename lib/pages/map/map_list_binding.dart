import 'package:daystodieutils/pages/map/map_list_controller.dart';
import 'package:get/get.dart';

class MapListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapListController());
  }
}
