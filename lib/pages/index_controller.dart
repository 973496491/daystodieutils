import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/pages/guide/item/list/item_list_controller.dart';
import 'package:daystodieutils/pages/login/login_controller.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  static String idLogin = "idLogin";

  bool _isLogin = false;
  String loginText = "管理员登录";

  @override
  void onInit() {
    _isLogin = true == UserManager
        .getToken()
        ?.isNotEmpty;
    setLoginText();
    super.onInit();
  }

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

  login() async {
    var context = Get.context;
    if (context == null) return;
    if (_isLogin) {
      var result = await context.showAskMessageDialog("是否注销登录?");
      if (OkCancelResult.ok == result) {
        UserManager.setToken(null);
        _isLogin = false;
      }
    } else {
      _isLogin = await _loginController().showLoginDialog(context);
    }
    setLoginText();
  }

  void setLoginText() {
    if (_isLogin) {
      loginText = "登出           ";
    } else {
      loginText = "管理员登录";
    }
    "loginText: $loginText".logD();
    update([idLogin]);
  }

  LoginController _loginController() {
    return Get.find<LoginController>();
  }
}
