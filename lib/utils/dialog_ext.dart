import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';

extension DialogExt on BuildContext {
  showMessageDialog(String? message) {
    if (true != message?.isNotEmpty) return;
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

  showListDialog(
    // String message,
    List<ListDialogEntity> actionInfo, {
    String title = "提示",
    String okLabel = "确定",
    String cancelLabel = "取消",
  }) {
    var actions = actionInfo
        .map((e) => AlertDialogAction(label: e.label, key: e.key))
        .toList();
    return showConfirmationDialog(
      context: this,
      title: title,
      // message: message,
      // okLabel: okLabel,
      // cancelLabel: cancelLabel,
      style: AdaptiveStyle.iOS,
      actions: actions,
    );
  }
}

class ListDialogEntity {
  ListDialogEntity(
    this.label,
    this.key,
  );

  String label;
  String key;
}
