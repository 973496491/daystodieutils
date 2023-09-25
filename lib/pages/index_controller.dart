import 'package:daystodieutils/config/config.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/pages/guide/item/list/item_list_controller.dart';
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

  toItemPage(int itemStatus) {
    Get.toNamed(
      RouteNames.guildItemList,
      parameters: {ItemListController.keyStatus: "$itemStatus"},
    );
  }
}
