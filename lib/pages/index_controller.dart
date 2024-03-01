import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/module/entity/banner_list_resp.dart';
import 'package:daystodieutils/module/event/login_event.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/pages/guide/item/list/item_list_controller.dart';
import 'package:daystodieutils/pages/login/login_controller.dart';
import 'package:daystodieutils/pages/register/register_controller.dart';
import 'package:daystodieutils/pages/service/item/list/service_item_list_controller.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/event_bus_utils.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  static String idLogin = "idLogin";
  static const String idBanner = "idBanner";

  List<BannerListEntity> banners = [];

  String loginText = "登录";

  StreamSubscription<LoginEvent>? event;

  @override
  void onInit() {
    var isLogin = true == UserManager.getToken()?.isNotEmpty;
    setLoginText(isLogin);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    EventBusUtils.listenLoginEvent((event) => setLoginText(event.isLogin));
    getBannerList();
  }

  @override
  void onClose() {
    event?.cancel();
    super.onClose();
  }

  void getBannerList() async {
    var respMap = await NHttpRequest.getBannerList();
    var resp =
        NRespFactory.parseArray<BannerListEntity>(respMap, BannerListEntity());
    var data = resp.data;
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      banners = data!;
      "banner init".logI();
      update([idBanner]);
    }
  }

  void toWhitelistPage() async {
    var canNext = await ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;
    Get.toNamed(RouteNames.whitelist);
  }

  void toMainMenuPage() async {
    var canNext = await ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;
    Get.toNamed(RouteNames.mainMenu);
  }

  toItemPage(int itemStatus) {
    Get.toNamed(
      RouteNames.guildItemList,
      parameters: {ItemListController.keyStatus: "$itemStatus"},
    );
  }

  void showServiceItemPageDialog() async {
    var context = Get.context;
    if (context == null) return;
    final result = await showTextInputDialog(
      context: context,
      title: "请输入服务器Key",
      okLabel: "确定",
      cancelLabel: "取消",
      style: AdaptiveStyle.iOS,
      textFields: [
        const DialogTextField(
          hintText: "请输入管理员提供的Key",
        ),
      ],
    );
    if (result == null) return;
    if (result.length != 1) return;
    String? key = result[0];
    if (key.isEmpty) return;
    toServiceItemPage(key: key);
  }

  toServiceItemPage({String? key}) async {
    if (key != null) {
      _toServiceItemPage(key);
      return;
    }
    var token = UserManager.getServiceKey();
    var sKey = UserManager.getServiceKey();
    if (token == null || sKey == null) {
      var isLogin = await _loginController().showLoginDialog(isService: true);
      if (isLogin) {
        var mKey = UserManager.getServiceKey();
        var message = "登录成功, 你的服务器Key是: $mKey";
        await Get.context?.showMessageDialog(message);
        _toServiceItemPage(mKey!);
      }
    } else {
      _toServiceItemPage(sKey);
    }
  }

  _toServiceItemPage(String key) {
    Get.toNamed(
      RouteNames.serviceItemList,
      parameters: {ServiceItemListController.keyServiceKey: key},
    );
  }

  login() async {
    var context = Get.context;
    if (context == null) return;
    var isLogin = true == UserManager.getToken()?.isNotEmpty;
    if (isLogin) {
      var result = await context.showAskMessageDialog("是否注销登录?");
      if (OkCancelResult.ok == result) {
        UserManager.setToken(null);
        EventBusUtils.pushLoginEvent(false);
      }
    } else {
      _loginController().showLoginDialog();
    }
  }

  void setLoginText(bool isLogin) {
    if (isLogin) {
      loginText = "登出           ";
    } else {
      loginText = "登录           ";
    }
    update([idLogin]);
  }

  void register(bool isLeaveRegister) {
    if (isLeaveRegister) {
      var adminLeave = UserManager.getUserInfo().userLeave ?? 0;
      if (adminLeave <= 3) {
        Get.context?.showAskMessageDialog("权限不足");
        return;
      }
    }
    _registerController().register(isLeaveRegister);
  }

  LoginController _loginController() {
    return Get.find<LoginController>();
  }

  RegisterController _registerController() {
    return Get.find<RegisterController>();
  }
}
