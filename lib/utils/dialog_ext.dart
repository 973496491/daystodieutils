import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:flutter/material.dart';

extension DialogExt on BuildContext {
  void showMessageDialog(String message, {Function? function}) {
    showOkAlertDialog(
      context: this,
      title: "提示",
      message: message,
      style: AdaptiveStyle.iOS,
    ).then((value) {
      if (function != null) {
        function();
      }
    });
  }
}
