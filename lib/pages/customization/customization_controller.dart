import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/pages/customization/customization_type_enum.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomizationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();

  int type = CustomizationTypeEnum.typeList[0].type;
  String typeDesc = CustomizationTypeEnum.typeList[0].typeDesc;

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    descController.dispose();
    contactInfoController.dispose();
  }

  void commit() async {
    var result = await Get.context?.showAskMessageDialog("注意: 提交后将不可更改, 是否提交?");
    if (OkCancelResult.ok == result) {
      _checkCommit();
    }
  }

  void _checkCommit() {
    var name = nameController.text;
    if (true != name.isNotEmpty) {
      Get.context?.showMessageDialog("定制名称不能为空.");
      return;
    }
    var contact = contactInfoController.text;
    if (true != contact.isNotEmpty) {
      Get.context?.showMessageDialog("联络方式不能为空.");
      return;
    }
    var desc = descController.text;
    _commit(name, desc, contact, type, typeDesc);
  }

  void _commit(
    String name,
    String? desc,
    String contact,
    int type,
    String typeDesc,
  ) async {
    var respMap = await NHttpRequest.commitCustomization(
      name,
      desc,
      contact,
      type,
      typeDesc,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      await Get.context?.showMessageDialog("已提交");
      Get.back();
    } else {
      Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "提交失败.",
      );
    }
  }
}
