import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

extension DialogExt on BuildContext {
  showMessageDialog(String message) {
    return showOkAlertDialog(
      context: this,
      title: "提示",
      message: message,
      style: AdaptiveStyle.iOS,
      barrierDismissible: false,
    );
  }

  showAskMessageDialog(
    String message, {
    String title = "提示",
    String okLabel = "确定",
    String cancelLabel = "取消",
  }) {
    return showOkCancelAlertDialog(
      context: this,
      title: title,
      message: message,
      okLabel: okLabel,
      cancelLabel: cancelLabel,
      style: AdaptiveStyle.iOS,
    );
  }
}
