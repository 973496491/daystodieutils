import 'package:daystodieutils/module/n_http_request.dart';
import 'package:daystodieutils/net/entity/zombie_detail_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideZombieController extends GetxController {
  static const String idContent = "idContent";
  static const String idEdit = "idEdit";
  static const String idCommit = "idCommit";
  static const String idDelete = "idDelete";

  bool isNewItem = false;

  bool canEdit = false;
  bool canCommit = false;
  bool canDelete = true;
  String editText = "编辑";

  int? _id;
  String zombieName = "--";
  String zombieType = "--";
  String zombieHp = "0";
  String bootyList = "无"; // 掉落物
  String corpseDrop = "无"; // 尸体材料
  String precautions = "无"; // 注意事项
  String raiders = "无";

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
    var resp = RespFactory.parseObject(respMap, ZombieDetailResp());
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

    bootyList = data.bootyList ?? "--";
    bootyListEditController.setText(bootyList);

    corpseDrop = data.corpseDrop ?? "--";
    corpseDropEditController.setText(corpseDrop);

    precautions = data.precautions ?? "--";
    precautionsEditController.setText(precautions);

    raiders = data.raiders ?? "--";
    raidersEditController.setText(raiders);
  }

  void changeCanEdit() {
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
        await Get.context?.showAskMessageDialog("是否提交修改?\n此操作将返回上级页面.");
    if (result != null) {
      _commit();
    }
  }

  void _commit() async {
    changeCanEdit();
    var respMap = await NHttpRequest.updateZombieDetail(
      _id,
      nameEditController.text,
      typeEditController.text,
      hpEditController.text,
      bootyListEditController.text,
      corpseDropEditController.text,
      precautionsEditController.text,
      raidersEditController.text,
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

  void delete() async {
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
    var respMap = await NHttpRequest.deleteZombieDetail(_id);
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
}
