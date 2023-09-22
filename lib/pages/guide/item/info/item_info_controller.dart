import 'package:daystodieutils/module/entity/item_info_resp.dart';
import 'package:daystodieutils/module/entity/upload_image_resp.dart';
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

class ItemInfoController extends GetxController {
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
    var canNext = ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

    var result = await Get.context?.showAskMessageDialog("是否删除此条目?");
    if (result != null) {
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
        Get.back(result: {"needReload", true});
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap) ?? "删除失败.");
    }
  }

  void commit() async {
    var result =
        await Get.context?.showAskMessageDialog("是否提交修改?\n此操作将返回上级页面.");
    if (result != null) {
      _commit();
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
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "成功",
      );
      if (result != null) {
        Get.back(result: {"needReload", true});
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap) ?? "提交失败.");
    }
  }

  changeCanEdit() {
    var canNext = ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

    canEdit = !canEdit;
    if (canEdit) {
      editText = "取消";
    } else {
      editText = "编辑";
    }
    canCommit = canEdit;
    canDelete = !canEdit;
    update([idEdit, idCommit, idDelete]);
    if (canEdit) {
      Future.delayed(const Duration(milliseconds: 50), () {
        FocusScope.of(Get.context!).requestFocus(focusNode);
      });
    }
  }

  void selectImage() async {
    var canNext = ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

    itemName = nameEditController.text;
    if (itemName!.isEmpty) {
      Get.context?.showMessageDialog("请输入古神名称再进行后续操作.");
      return;
    }

    var xFile = await _picker.getImageFromSource(source: ImageSource.gallery);
    if (xFile == null) {
      return;
    }
    var name = xFile.name;
    var suffix = name.substring(name.lastIndexOf("."));
    var bytes = await xFile.readAsBytes();
    var fileName = "$itemName$suffix";

    var file = MultipartFile.fromBytes(bytes.toList(), filename: fileName);
    var respMap = await NHttpRequest.uploadImage(itemName!, file);
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
