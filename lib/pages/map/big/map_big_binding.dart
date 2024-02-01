import 'package:daystodieutils/pages/map/big/map_big_controller.dart';
import 'package:get/get.dart';

class MapBigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapBigController());
  }
}
