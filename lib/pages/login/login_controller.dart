import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/entity/login_resp.dart';
import 'package:daystodieutils/net/http.dart';
import 'package:daystodieutils/net/http_api.dart';
import 'package:daystodieutils/net/resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
    if (context.mounted) {
      _login(context, result);
    }
  }

  _login(BuildContext context, List<String>? value) async {
    if (value == null) {
      return;
    }
    if (value.length != 2) {
      context.showMessageDialog("请输入正确的账号密码.");
      return;
    }
    var username = value[0];
    var password = value[1];
    if (username.isEmpty || password.isEmpty) {
      context.showMessageDialog("请输入正确的账号密码.");
      return;
    }
    var respMap = await Http.post(
      HttpApi.login,
      data: {"username": username, "password": password},
    );
    var resp = RespFactory.parseObject<LoginResp>(respMap, LoginResp());
    var token = resp.data?.token;
    if (token != null) {
      UserManager.setToken(resp.data?.token);
      if (context.mounted) {
        context.showMessageDialog("登录成功");
      }
    }
  }
}
