import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/utils/list_ext.dart';
import 'package:get/get.dart';
import 'package:daystodieutils/utils/string_ext.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';

class RegisterController extends GetxController {
  void register(bool isLeaveRegister) {
    showRegisterDialog(isLeaveRegister);
  }

  Future<bool> showRegisterDialog(bool isLeaveRegister) async {
    var context = Get.context;
    if (context == null) {
      return Future.value(false);
    }
    final result = await showTextInputDialog(
      context: context,
      title: "注册",
      okLabel: "注册",
      cancelLabel: "取消",
      style: AdaptiveStyle.iOS,
      textFields: _fieldWidget(isLeaveRegister),
    );
    return _check(result);
  }

  _fieldWidget(bool isLeaveRegister) {
    var list = <DialogTextField>[];
    list.add(
      const DialogTextField(
        hintText: "请输入账号",
      ),
    );
    list.add(
      const DialogTextField(
        hintText: "请输入密码",
      ),
    );
    if (isLeaveRegister) {
      list.add(
        const DialogTextField(
          hintText: "用户等级",
        ),
      );
    }
    return list;
  }

  Future<bool> _check(
    List<String>? value,
  ) async {
    try {
      if (value == null) {
        return Future.value(false);
      }
      var username = value.getOrNull(0);
      var password = value.getOrNull(1);
      var leave = value.getOrNull(2);
      if (username.isEmpty || password.isEmpty) {
        Get.context?.showMessageDialog("请输入正确的账号密码.");
        return Future.value(false);
      }
      int userLeave = (leave as String?).safeToInt();
      return _register(username, password, userLeave);
    } catch (ex) {
      ex.printError();
      return Future.value(false);
    }
  }

  Future<bool> _register(
    String username,
    String password,
    int userLeave,
  ) async {
    var respMap = await NHttpRequest.register(
      username,
      base64.encode(utf8.encode(password)).toString(),
      userLeave,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      Get.context?.showMessageDialog("注册成功");
      return Future.value(true);
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap));
      return Future.value(false);
    }
  }
}
