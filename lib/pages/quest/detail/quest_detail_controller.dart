import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/permission_config.dart';
import 'package:daystodieutils/module/entity/quest_detail_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:daystodieutils/utils/page_utils.dart';
import 'package:daystodieutils/utils/upload_utils.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;

class QuestDetailController extends GetxController {
  static const String idIcon = "idIcon";
  static const String idEdit = "idEdit";
  static const String idCommit = "idCommit";
  static const String idDelete = "idDelete";

  bool canEdit = false;
  bool canCommit = false;
  bool canDelete = true;

  FocusNode? focusNode;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController getWayEditController = TextEditingController();
  TextEditingController workstationEditController = TextEditingController();
  TextEditingController recipesEditController = TextEditingController();
  TextEditingController introductionEditController = TextEditingController();
  TextEditingController raidersEditController = TextEditingController();

  String? _id;
  String? itemName;
  String? iconUrl;
  List<String> recipesArray = []; // 合成配方

  String editText = "编辑";

  @override
  void onReady() {
    super.onReady();
    _initInfo();
  }

  @override
  void onClose() {
    nameEditController.dispose();
    getWayEditController.dispose();
    workstationEditController.dispose();
    recipesEditController.dispose();
    introductionEditController.dispose();
    raidersEditController.dispose();
    focusNode?.dispose();
    super.onClose();
  }

  void _initInfo() {
    _id = Get.parameters["id"];
    "id: ${_id == "null"}".logD();
    if (_id != null) {
      _initItemInfoData(_id!);
    }
  }

  void _initItemInfoData(String id) async {
    var respMap = await NHttpRequest.getQuestDetail(id);
    var resp = NRespFactory.parseObject(respMap, QuestDetailResp());
    var data = resp.data;
    if (data == null) {
      Get.context?.showMessageDialog(resp.message);
      return;
    }

    itemName = data.name;
    nameEditController.setText(itemName ?? "--");
    getWayEditController.setText(data.getWay);
    workstationEditController.setText(data.workstation);
    raidersEditController.setText(data.raiders);

    introductionEditController.setText(data.introduction);

    // 合成配方
    var recipes = data.recipes;
    if (recipes != null) {
      recipesArray = recipes.split(",");
      var corpseDrop = _parseTextToShow(recipesArray);
      recipesEditController.setText(corpseDrop);
    }

    iconUrl = data.imageUrl;
    if (iconUrl != null) {
      update([idIcon]);
    }
  }

  String _parseTextToShow(List<String> array) {
    var str = "";
    var i = 0;
    for (var element in array) {
      if (i > 0) {
        str += "\n";
      }
      str += element;
      i++;
    }
    return str;
  }

  changeCanEdit() {
    canEdit = !canEdit;
    if (canEdit) {
      editText = "取消";
    } else {
      editText = "编辑";
    }
    canDelete = !canEdit;
    canCommit = canEdit;
    update([idEdit, idCommit, idDelete]);
    if (canEdit) {
      Future.delayed(const Duration(milliseconds: 50), () {
        FocusScope.of(Get.context!).requestFocus(focusNode);
      });
    }
  }

  delete() async {
    if (!PageUtils.permissionCheck(PermissionConfig.deleteQuests)) {
      return;
    }
    var result = await Get.context?.showAskMessageDialog("是否删除此条目?");
    if (OkCancelResult.ok == result) {
      _delete();
    }
  }

  void _delete() async {
    if (_id == null) {
      Get.context?.showMessageDialog("任务不存在");
      return;
    }
    var respMap = await NHttpRequest.deleteQuest("$_id");
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap),
      );
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(
        NHttpConfig.message(respMap),
      );
    }
  }

  void commit() async {
    if (!PageUtils.permissionCheck(PermissionConfig.editQuests)) {
      return;
    }
    var result = await Get.context?.showAskMessageDialog(
      "是否提交修改?\n此操作将返回上级页面.",
    );
    "commit: $result".logD();
    if (OkCancelResult.ok != result) {
      return;
    }
    var notExist = await getItemNameIsExist();
    if (!notExist) {
      var result = await Get.context?.showAskMessageDialog(
        "道具已存在, 是否继续提交?",
      );
      if (OkCancelResult.ok == result) {
        _commit();
      }
    } else {
      _commit();
    }
  }

  void _commit() async {
    changeCanEdit();
    var recipes = recipesEditController.text.replaceAll("\n", ",");
    var respMap = await NHttpRequest.updateQuestInfo(
      _id,
      nameEditController.text,
      getWayEditController.text,
      workstationEditController.text,
      recipes,
      introductionEditController.text,
      raidersEditController.text,
      iconUrl,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap),
      );
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(
        NHttpConfig.message(respMap),
      );
    }
  }

  Future<bool> getItemNameIsExist() async {
    var name = nameEditController.text;
    var respMap = await NHttpRequest.checkItemNotExist(name);
    if (NHttpConfig.isOk(map: respMap)) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  void selectImage() async {
    if (!canEdit) return;

    itemName = nameEditController.text;
    if (true != itemName?.isNotEmpty) {
      Get.context?.showMessageDialog("请输入古神名称再进行后续操作.");
      return;
    }

    var url = await UploadUtils.uploadImage(itemName!);
    if (url != null) {
      iconUrl = "$url?${DateTime.now().millisecondsSinceEpoch}";
      update([idIcon]);
      Future.delayed(const Duration(milliseconds: 100), () {
        iconUrl = url;
      });
    }
  }
}
