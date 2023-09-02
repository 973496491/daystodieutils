import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/entity/main_menu_item_resp.dart';
import 'package:daystodieutils/net/http.dart';
import 'package:daystodieutils/module/n_http_api.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_content_type.dart';
import 'package:daystodieutils/net/resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MainMenuController extends GetxController {
  static const String idListView = "idListView";
  static const String _typeEdit = "edit";
  static const String _typeDelete = "_delete";

  List<MainMenuItemResp> itemList = [];

  @override
  void onReady() {
    super.onReady();
    _getItemInfoList();
  }

  void _getItemInfoList() async {
    var respMap = await Http.get(NHttpApi.getMainMenuItemList);
    var resp =
        RespFactory.parseArray<MainMenuItemResp>(respMap, MainMenuItemResp());
    var data = resp.data;
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      itemList = data!;
    }
    update([idListView]);
  }

  void showEditDialog(BuildContext context, MainMenuItemResp item) async {
    var key = await showConfirmationDialog(
      context: context,
      title: "请选择功能项",
      style: AdaptiveStyle.iOS,
      actions: [
        const AlertDialogAction(
          label: "编辑",
          textStyle: TextStyle(),
          key: _typeEdit,
        ),
        const AlertDialogAction(
          label: "删除",
          textStyle: TextStyle(),
          key: _typeDelete,
        ),
      ],
    );
    if (key == null) return;
    switch (key) {
      case _typeDelete:
        {
          // ignore: use_build_context_synchronously
          _deleteItem(item.id!);
          break;
        }
      case _typeEdit:
        {
          // ignore: use_build_context_synchronously
          showEditBtnInfoDialog(context, false, item: item);
          break;
        }
    }
  }

  void _deleteItem(int id) async {
    var reqMap = {"id": "$id"};
    var resp = await Http.post(
      NHttpApi.deleteMainMenuBtnInfo,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
    if (NHttpConfig.isOk(map: resp)) {
      var result = await Get.context?.showMessageDialog("删除成功.");
      if (result != null) {
        _getItemInfoList();
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(resp) ?? "删除失败");
    }
  }

  void showEditBtnInfoDialog(BuildContext context, bool isAdd,
      {MainMenuItemResp? item}) async {
    var title = "添加主菜单按钮信息";
    if (!isAdd) title = "编辑主菜单按钮信息";

    var okLabel = "添加";
    if (!isAdd) okLabel = "编辑";

    final result = await showTextInputDialog(
      context: context,
      title: title,
      okLabel: okLabel,
      cancelLabel: "取消",
      style: AdaptiveStyle.iOS,
      textFields: [
        DialogTextField(hintText: "请输入按钮 Name", initialText: item?.name ?? ""),
        DialogTextField(hintText: "请输入跳转地址 Url", initialText: item?.url ?? ""),
      ],
    );
    _addBtnItem(result, isAdd, id: item?.id);
  }

  void _addBtnItem(List<String>? result, bool isAdd, {int? id}) {
    if (result == null) return;
    if (true != result.isNotEmpty) {
      Get.context?.showMessageDialog("请输入正确的按钮信息.");
      return;
    }
    if (result.length != 2) {
      Get.context?.showMessageDialog("请输入正确的按钮信息.");
      return;
    }
    var name = result[0];
    var url = result[1];
    if (name.isEmpty || url.isEmpty) {
      Get.context?.showMessageDialog("请输入正确的按钮信息.");
      return;
    }
    var data = {
      "name": name,
      "url": url,
    };
    if (isAdd) {
      _addItem(data);
    } else {
      data["id"] = "$id";
      _editItem(data);
    }
  }

  void _addItem(Map<String, String> info) async {
    var respMap = await Http.post(
      NHttpApi.addMainMenuItem,
      data: info,
      contentType: NHttpContentType.formUrlencoded.type,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog("添加按钮信息成功.");
      if (result != null) {
        _getItemInfoList();
      }
    } else {
      Get.context?.showMessageDialog(
        NHttpConfig.message(respMap) ?? "添加按钮信息失败",
      );
    }
  }

  void _editItem(Map<String, String> info) async {
    var resp = await Http.post(
      NHttpApi.editMainMenuBtnInfo,
      data: info,
    );
    if (NHttpConfig.isOk(map: resp)) {
      var result = await Get.context?.showMessageDialog("编辑成功.");
      if (result != null) {
        _getItemInfoList();
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(resp) ?? "编辑失败");
    }
  }
}
