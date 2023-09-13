import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../module/entity/login_resp.dart';

class LoginController extends GetxController {
  void showLoginDialog(BuildContext context) async {
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
    _login(result);
  }

  _login(List<String>? value) async {
    if (value == null) {
      return;
    }
    if (value.length != 2) {
      Get.context?.showMessageDialog("请输入正确的账号密码.");
      return;
    }
    var username = value[0];
    var password = value[1];
    if (username.isEmpty || password.isEmpty) {
      Get.context?.showMessageDialog("请输入正确的账号密码.");
      return;
    }
    var respMap = await NHttpRequest.login(username, password);
    var resp = NRespFactory.parseObject<LoginResp>(respMap, LoginResp());
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      var token = resp.data?.token;
      if (token != null) {
        UserManager.setToken(resp.data?.token);
        Get.context?.showMessageDialog("登录成功");
      }
    } else {
      Get.context?.showMessageDialog(resp.message ?? "登录失败");
    }
  }
}
