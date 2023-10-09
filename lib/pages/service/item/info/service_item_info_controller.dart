import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/module/entity/service_item_info_resp.dart';
import 'package:daystodieutils/module/entity/upload_image_resp.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class ServiceItemInfoController extends GetxController {
  static const String idContent = "idContent";
  static const String idIcon = "idIcon";
  static const String idEdit = "idEdit";
  static const String idCommit = "idCommit";
  static const String idDelete = "idDelete";

  final _picker = ImagePickerPlugin();

  bool isNewItem = false;
  bool canEdit = false;
  bool canCommit = false;
  bool canDelete = true;
  String editText = "编辑";

  String? serviceKey;

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
    _initInfo();
    super.onInit();
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
    serviceKey = UserManager.getServiceKey();
    var id = Get.parameters["id"];
    if (id == null || id == "-1") {
      isNewItem = true;
    } else {
      isNewItem = false;
      _initItemInfoData(id);
    }
  }

  void _initItemInfoData(String id) async {
    var respMap = await NHttpRequest.getServiceItemInfo(id);
    var resp = NRespFactory.parseObject(respMap, ServiceItemInfoResp());
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
    var canNext = true == UserManager.getServiceToken()?.isNotEmpty;
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
    var respMap = await NHttpRequest.deleteServiceItem(
      "$_id",
      UserManager.getServiceToken(),
    );
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
    _commit();
  }

  void _commit() async {
    changeCanEdit();
    var respMap = await NHttpRequest.updateServiceItemInfo(
      _id,
      UserManager.getServiceToken(),
      nameEditController.text,
      getWayEditController.text,
      introductionEditController.text,
      iconUrl,
      thumbnailUrl,
      serviceKey,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      String message = NHttpConfig.message(respMap) ?? "成功";
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

  void selectImage() async {
    if (!canEdit) return;

    var serviceToken = UserManager.getServiceToken();
    if (serviceToken == null) {
      return;
    }

    itemName = nameEditController.text;
    if (itemName!.isEmpty) {
      Get.context?.showMessageDialog("请输入道具名称再进行后续操作.");
      return;
    }

    var xFile = await _picker.getImageFromSource(source: ImageSource.gallery);
    if (xFile == null) {
      return;
    }
    var name = xFile.name;
    var suffix = name.substring(name.lastIndexOf("."));
    var bytes = await xFile.readAsBytes();
    var fileName = "$itemName$serviceKey$suffix";

    var file = MultipartFile.fromBytes(bytes.toList(), filename: fileName);
    var respMap =
        await NHttpRequest.uploadServiceImage(fileName, serviceToken, file);
    var resp = NRespFactory.parseObject(respMap, UploadImageResp());
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      var url = resp.data?.url;
      if (url == null) {
        Get.context?.showMessageDialog("图片地址为空");
      } else {
        iconUrl = resp.data?.url ?? "";
        thumbnailUrl = resp.data?.thumbnailUrl;
        update([idIcon]);
      }
    } else {
      Get.context?.showMessageDialog(resp.message!);
    }
  }
}
