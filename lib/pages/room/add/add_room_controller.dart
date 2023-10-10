import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/module/entity/room_list_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/upload_utils.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoomController extends GetxController {
  static const String idIcon = "idIcon";
  static const String idEdit = "idEdit";
  static const String idCommit = "idCommit";
  static const String idDelete = "idDelete";

  FocusNode? focusNode;
  TextEditingController nameEditController = TextEditingController();
  TextEditingController numberEditController = TextEditingController();
  TextEditingController urlEditController = TextEditingController();

  String editText = "编辑";
  bool canEdit = false;
  bool canDelete = true;
  bool canCommit = false;

  int? _id;
  String? iconUrl;
  String? itemName;

  @override
  void onReady() {
    super.onReady();
    var id = Get.parameters["id"];
    if (id != null) {
      _initItemInfoData(id);
    }
  }

  @override
  void onClose() {
    nameEditController.dispose();
    numberEditController.dispose();
    urlEditController.dispose();
    focusNode?.dispose();
    super.onClose();
  }

  void _initItemInfoData(String id) async {
    var respMap = await NHttpRequest.getRoomItemInfo(id);
    var resp = NRespFactory.parseObject(respMap, RoomListResp());
    var data = resp.data;
    if (data == null) {
      Get.context?.showMessageDialog(resp.message);
      return;
    }
    _id = data.id;

    nameEditController.setText(data.name);
    numberEditController.setText(data.roomNumber);
    urlEditController.setText(data.roomUrl);

    iconUrl = data.roomIcon;
    if (iconUrl != null) {
      update([idIcon]);
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

  delete() async {
    var canNext = await ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

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
    var respMap = await NHttpRequest.deleteRoomItem("$_id");
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
    var result = await Get.context?.showAskMessageDialog(
      "是否提交修改?\n此操作将返回上级页面.",
    );
    if (OkCancelResult.ok != result) {
      return;
    }
    var notItem = await getRoomNameNotExist();
    if (!notItem) {
      var result = await Get.context?.showAskMessageDialog("QQ群信息已存在, 是否继续提交?");
      if (OkCancelResult.ok == result) {
        _commit();
      }
    } else {
      _commit();
    }
  }

  void _commit() async {
    changeCanEdit();
    var respMap = await NHttpRequest.updateQQRoomItemInfo(
      _id,
      nameEditController.text,
      numberEditController.text,
      urlEditController.text,
      iconUrl,
      null,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap),
      );
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap) ?? "提交失败.");
    }
  }

  Future<bool> getRoomNameNotExist() async {
    var roomNumber = numberEditController.text;
    var respMap = await NHttpRequest.getRoomNumberIsExist(roomNumber);
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
      Get.context?.showMessageDialog("请输入群名称再进行后续操作.");
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
