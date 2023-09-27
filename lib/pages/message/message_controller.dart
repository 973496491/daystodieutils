import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();

  void commit() async {
    var result = await Get.context?.showAskMessageDialog("提交后将不可更改, 是否提交?");
    if (OkCancelResult.ok == result) {
      _checkCommit();
    }
  }

  void _checkCommit() {
    var name = nameController.text;
    if (true != name.isNotEmpty) {
      Get.context?.showMessageDialog("昵称不能为空.");
      return;
    }
    var message = contentController.text;
    if (true != message.isNotEmpty) {
      Get.context?.showMessageDialog("意见不能为空.");
      return;
    }
    var contactInfo = contactInfoController.text;
    _commit(name, message, contactInfo);
  }

  void _commit(
    String name,
    String message,
    String? contactInfo,
  ) async {
    var respMap = await NHttpRequest.commitFeedback(name, message, contactInfo);
    if (NHttpConfig.isOk(map: respMap)) {
      await Get.context?.showMessageDialog("反馈已提交");
      Get.back();
    } else {
      Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "反馈已提交失败.",
      );
    }
  }
}
