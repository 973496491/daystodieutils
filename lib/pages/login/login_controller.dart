import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/event_bus_utils.dart';
import 'package:get/get.dart';

import '../../module/entity/login_resp.dart';
import '../../module/entity/login_service_resp.dart';

class LoginController extends GetxController {
  Future<bool> showLoginDialog({
    bool isService = false,
  }) async {
    var context = Get.context;
    if (context == null) {
      return Future.value(false);
    }
    final result = await showTextInputDialog(
      context: context,
      title: "管理员登录",
      okLabel: "登录",
      cancelLabel: "取消",
      style: AdaptiveStyle.iOS,
      textFields: [
        const DialogTextField(
          hintText: "请输入账号",
        ),
        const DialogTextField(
          hintText: "请输入密码",
        ),
      ],
    );
    return _check(result, isService);
  }

  Future<bool> _check(
    List<String>? value,
    bool isService,
  ) async {
    if (value == null) {
      return Future.value(false);
    }
    if (value.length != 2) {
      Get.context?.showMessageDialog("请输入正确的账号密码.");
      return Future.value(false);
    }
    var username = value[0];
    var password = value[1];
    if (username.isEmpty || password.isEmpty) {
      Get.context?.showMessageDialog("请输入正确的账号密码.");
      return Future.value(false);
    }
    if (isService) {
      return _serviceLogin(username, password);
    } else {
      return _adminLogin(username, password);
    }
  }

  Future<bool> _adminLogin(
    String username,
    String password,
  ) async {
    var respMap = await NHttpRequest.login(username, password);
    var resp = NRespFactory.parseObject<LoginResp>(respMap, LoginResp());
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      var token = resp.data?.token;
      if (token != null) {
        UserManager.setToken(resp.data?.token);
        Get.context?.showMessageDialog("登录成功");
        EventBusUtils.pushLoginEvent(true);
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      Get.context?.showMessageDialog(resp.message);
      return Future.value(false);
    }
  }

  Future<bool> _serviceLogin(
    String username,
    String password,
  ) async {
    var respMap = await NHttpRequest.serviceLogin(username, password);
    var resp = NRespFactory.parseObject(respMap, LoginServiceResp());
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      var token = resp.data?.token;
      var key = resp.data?.key;
      if (token != null && key != null) {
        UserManager.setServiceToken(token);
        UserManager.setServiceKey(key);
        Get.context?.showMessageDialog("登录成功");
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      Get.context?.showMessageDialog(resp.message ?? "登录失败");
      return Future.value(false);
    }
  }
}
