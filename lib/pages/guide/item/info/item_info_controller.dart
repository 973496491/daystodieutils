import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/config.dart';
import 'package:daystodieutils/config/permission_config.dart';
import 'package:daystodieutils/module/entity/item_info_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/pages/guide/item/list/item_list_controller.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:daystodieutils/utils/page_utils.dart';
import 'package:daystodieutils/utils/upload_utils.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;

class ItemInfoController extends GetxController {
  static const String idContent = "idContent";
  static const String idIcon = "idIcon";
  static const String idEdit = "idEdit";
  static const String idCommit = "idCommit";
  static const String idDelete = "idDelete";
  static const String idReject = "idReject";
  static const String idPass = "idPass";

  bool isNewItem = false;
  String status = "${Config.itemStatusReviewed}";
  bool canEdit = false;
  bool canCommit = false;
  bool canPass = false;
  bool canReject = false;
  bool canDelete = true;
  String editText = "编辑";

  int? _id;
  String? itemName;
  String? getWay;
  String? introduction;
  String? iconUrl;
  String? thumbnailUrl;

  FocusNode? focusNode;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController getWayEditController = TextEditingController();
  TextEditingController introductionEditController = TextEditingController();

  @override
  void onInit() {
    var mStatus = Get.parameters[ItemListController.keyStatus];
    if (mStatus != null) {
      status = mStatus;
      if ("${Config.itemStatusUnreview}" == mStatus) {
        canReject = true;
        canPass = true;
        canDelete = false;
        update([idReject, idPass, idDelete]);
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _initInfo();
  }

  @override
  void onClose() {
    nameEditController.dispose();
    getWayEditController.dispose();
    introductionEditController.dispose();
    focusNode?.dispose();
    super.onClose();
  }

  void _initInfo() {
    var id = Get.parameters["id"];
    if (id == null || id == "-1") {
      isNewItem = true;
    } else {
      isNewItem = false;
      _initItemInfoData(id);
    }
  }

  void _initItemInfoData(String id) async {
    var respMap = await NHttpRequest.getItemInfo(id);
    var resp = NRespFactory.parseObject(respMap, ItemInfoResp());
    var data = resp.data;
    if (data == null) {
      Get.context?.showMessageDialog(resp.message ?? "获取详情失败.");
      return;
    }
    _id = data.id;

    itemName = data.name;
    nameEditController.setText(itemName ?? "--");

    getWay = data.getWay;
    getWayEditController.setText(getWay ?? "--");

    introduction = data.introduction;
    introductionEditController.setText(introduction ?? "--");

    thumbnailUrl = data.thumbnailUrl;

    iconUrl = data.imageUrl;
    if (iconUrl != null) {
      update([idIcon]);
    }
  }

  delete() async {
    if (!PageUtils.permissionCheck(PermissionConfig.deleteGuideItem)) {
      return;
    }
    var result = await Get.context?.showAskMessageDialog("是否删除此条目?");
    if (OkCancelResult.ok == result) {
      _delete();
    }
  }

  void _delete() async {
    if (_id == null) {
      Get.context?.showMessageDialog("条目不存在");
      return;
    }
    var respMap = await NHttpRequest.deleteItem("$_id");
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "删除成功",
      );
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap) ?? "删除失败.");
    }
  }

  void commit() async {
    var result =
        await Get.context?.showAskMessageDialog("是否提交修改?\n此操作将返回上级页面.");
    if (OkCancelResult.ok != result) {
      return;
    }
    var hasItem = await getItemNameIsExist();
    if (true == hasItem) {
      var result = await Get.context?.showAskMessageDialog("道具已存在, 是否继续提交?");
      if (OkCancelResult.ok == result) {
        _commit();
      }
    } else if (false == hasItem) {
      _commit();
    } else {
      Get.context?.showAskMessageDialog("未知异常.");
    }
  }

  void _commit() async {
    changeCanEdit();
    var respMap = await NHttpRequest.updateItemInfo(
      _id,
      nameEditController.text,
      getWayEditController.text,
      introductionEditController.text,
      iconUrl,
      thumbnailUrl,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      String message;
      if (status == "${Config.itemStatusReviewed}") {
        message = NHttpConfig.message(respMap) ?? "成功";
      } else {
        message = "已提交, 请耐心等待管理员审核 .";
      }
      var result = await Get.context?.showMessageDialog(message);
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap) ?? "提交失败.");
    }
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

  void review() async {
    if (!PageUtils.permissionCheck(PermissionConfig.reviewGuideItem)) {
      return;
    }
    var result = await Get.context?.showAskMessageDialog("是否通过此提交?");
    if (OkCancelResult.ok == result) {
      _review();
    }
  }

  void _review() async {
    var hasItem = await getItemNameIsExist();
    if (true == hasItem) {
      var result = await Get.context?.showAskMessageDialog("道具已存在, 是否继续通过?");
      if (OkCancelResult.ok != result) {
        return;
      }
    } else {
      return;
    }

    var respMap = await NHttpRequest.passItemReview("$_id");
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "成功",
      );
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap) ?? "审核失败.");
    }
  }

  Future<bool?> getItemNameIsExist() async {
    var name = nameEditController.text;
    var respMap = await NHttpRequest.getItemNameIsExist(name);
    if (NHttpConfig.isOk(map: respMap)) {
      return Future.value(true);
    } else {
      var code = NHttpConfig.code(respMap);
      "code: $code".logD();
      if (-3 == code) {
        return Future.value(false);
      } else {
        return Future.value(null);
      }
    }
  }

  void selectImage() async {
    if (!canEdit) return;

    itemName = nameEditController.text;
    if (true != itemName?.isNotEmpty) {
      Get.context?.showMessageDialog("请输入道具名称再进行后续操作.");
      return;
    }

    var url = await UploadUtils.uploadImage(itemName!, needToken: false);
    if (url != null) {
      iconUrl = "$url?${DateTime.now().millisecondsSinceEpoch}";
      update([idIcon]);
      Future.delayed(const Duration(milliseconds: 100), () {
        iconUrl = url;
      });
    }
  }
}
