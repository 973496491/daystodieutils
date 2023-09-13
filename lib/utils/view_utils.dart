import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../module/user/user_manager.dart';

class ViewUtils {
  static AppBar getAppBar(String title, {List<Widget>? actions}) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
        ),
      ),
      actions: actions,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  static bool checkOptionPermissions(BuildContext? context) {
    if (UserManager.getToken() == null) {
      context?.showMessageDialog("权限不足");
      return false;
    } else {
      return true;
    }
  }
}
