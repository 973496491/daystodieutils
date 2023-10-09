import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

import '../../../../module/entity/upload_image_resp.dart';
import '../../../../module/entity/zombie_detail_resp.dart';

class GuideZombieController extends GetxController {
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
  String zombieName = "--";
  String zombieType = "--";
  String zombieHp = "0";
  List<String> bootyListArray = []; // 掉落物
  List<String> corpseDropArray = []; // 尸体材料
  String precautions = "无"; // 注意事项
  String raiders = "无";
  String? iconUrl;

  FocusNode? focusNode;

  TextEditingController nameEditController = TextEditingController();
  TextEditingController typeEditController = TextEditingController();
  TextEditingController hpEditController = TextEditingController();
  TextEditingController bootyListEditController = TextEditingController();
  TextEditingController corpseDropEditController = TextEditingController();
  TextEditingController precautionsEditController = TextEditingController();
  TextEditingController raidersEditController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    _initInfo();
  }

  @override
  void onClose() {
    nameEditController.dispose();
    typeEditController.dispose();
    hpEditController.dispose();
    bootyListEditController.dispose();
    corpseDropEditController.dispose();
    precautionsEditController.dispose();
    focusNode?.dispose();
    super.onClose();
  }

  void _initInfo() {
    var id = Get.parameters["id"];
    if (id == null || id == "-1") {
      isNewItem = true;
    } else {
      isNewItem = false;
      _initZombieListData(id);
    }
  }

  void _initZombieListData(String id) async {
    var respMap = await NHttpRequest.getZombieDetail(id);
    var resp = NRespFactory.parseObject(respMap, ZombieDetailResp());
    var data = resp.data;
    if (data == null) {
      Get.context?.showMessageDialog(resp.message ?? "获取详情失败.");
      return;
    }
    _id = data.id;

    zombieName = data.name ?? "--";
    nameEditController.setText(zombieName);

    zombieType = data.zombieType ?? "--";
    typeEditController.setText(zombieType);

    zombieHp = data.zombieHp ?? "--";
    hpEditController.setText(zombieHp);

    // 掉落物
    var bl = data.bootyList;
    if (bl != null) {
      bootyListArray = bl.split(",");
      var bootyList = _parseTextToShow(bootyListArray);
      bootyListEditController.setText(bootyList);
    }

    // 尸体材料
    var cd = data.corpseDrop;
    if (cd != null) {
      corpseDropArray = cd.split(",");
      var corpseDrop = _parseTextToShow(corpseDropArray);
      corpseDropEditController.setText(corpseDrop);
    }

    precautions = data.precautions ?? "--";
    precautionsEditController.setText(precautions);

    raiders = data.raiders ?? "--";
    raidersEditController.setText(raiders);

    iconUrl = data.imageUrl;
    if (iconUrl != null) {
      update([idIcon]);
    }
  }

  void changeCanEdit() {
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

  void commit() async {
    var result =
    await Get.context?.showAskMessageDialog(
        "是否提交修改?\n此操作将返回上级页面.");
    if (OkCancelResult.ok == result) {
      _commit();
    }
  }

  void _commit() async {
    changeCanEdit();
    var bootList = bootyListEditController.text.replaceAll("\n", ",");
    var respMap = await NHttpRequest.updateZombieDetail(
      _id,
      nameEditController.text,
      typeEditController.text,
      hpEditController.text,
      bootList,
      corpseDropEditController.text,
      precautionsEditController.text,
      raidersEditController.text,
      iconUrl,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "成功",
      );
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(
          NHttpConfig.message(respMap) ?? "提交失败.");
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

  void delete() async {
    var canNext = ViewUtils.checkOptionPermissions(Get.context);
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
    var respMap = await NHttpRequest.deleteZombieDetail(_id);
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "删除成功",
      );
      if (result != null) {
        Get.back(result: true);
      }
    } else {
      Get.context?.showMessageDialog(
          NHttpConfig.message(respMap) ?? "删除失败.");
    }
  }

  void selectImage() async {
    var canNext = ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

    zombieName = nameEditController.text;
    if (zombieName.isEmpty) {
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
    var fileName = "$zombieName$suffix";

    var file = MultipartFile.fromBytes(bytes.toList(), filename: fileName);
    var respMap = await NHttpRequest.uploadImage(fileName, file);
    var resp = NRespFactory.parseObject(respMap, UploadImageResp());
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      var url = resp.data?.url;
      if (url == null) {
        Get.context?.showMessageDialog("图片地址为空");
      } else {
        iconUrl = resp.data?.url ?? "";
        update([idIcon]);
      }
    } else {
      Get.context?.showMessageDialog(resp.message!);
    }
  }

  void showItemDetailPageDialog(List<String> array) async {
    "array: $array | ${array.length}".logD();
    if (array.isEmpty) return;
    var actions = array.map((e) => ListDialogEntity(e, e)).toList();
    var result = await Get.context?.showListDialog(actions);
    var respMap = await NHttpRequest.getItemIds(result);
    if (NHttpConfig.isOk(map: respMap)) {
      try {
        var data = NHttpConfig.data(respMap);
        var id = (data as List)[0];
        if (id == null) return;
        var parameters = {
          "id": "$id",
          "canEdit": "${false}",
        };
        Get.toNamed(RouteNames.itemInfo, parameters: parameters);
      } catch (ex) {
        ex.printError();
      }
    } else {
      var msg = NHttpConfig.message(respMap);
      Get.context?.showMessageDialog(msg);
    }
  }
}
