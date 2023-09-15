import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  void toWhitelistPage() {
    if (!ViewUtils.checkOptionPermissions(Get.context)) {
      return;
    }
    Get.toNamed(RouteNames.whitelist);
  }

  void toMainMenuPage() {
    if (!ViewUtils.checkOptionPermissions(Get.context)) {
      return;
    }
    Get.toNamed(RouteNames.mainMenu);
  }
}
