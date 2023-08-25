import 'package:daystodieutils/pages/login/login_controller.dart';
import 'package:get/get.dart';

import 'index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => LoginController());
  }
}
