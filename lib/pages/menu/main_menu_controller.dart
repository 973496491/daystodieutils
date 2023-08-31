import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/entity/main_menu_item_resp.dart';
import 'package:daystodieutils/net/http.dart';
import 'package:daystodieutils/net/http_api.dart';
import 'package:daystodieutils/net/http_config.dart';
import 'package:daystodieutils/net/http_content_type.dart';
import 'package:daystodieutils/net/resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
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
    var respMap = await Http.get(HttpApi.getMainMenuItemList);
    var resp =
    RespFactory.parseArray<MainMenuItemResp>(respMap, MainMenuItemResp());
    var data = resp.data;
    if (HttpConfig.isOk(bizCode: resp.code)) {
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
          _deleteItem(context, item.id!);
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

  void _deleteItem(BuildContext context, int id) async {
    var reqMap = {"id": "$id"};
    var resp = await Http.post(
      HttpApi.deleteMainMenuBtnInfo,
      data: reqMap,
      contentType: HttpContentType.formUrlencoded.type,
    );
    if (!context.mounted) return;
    if (HttpConfig.isOk(map: resp)) {
      context.showMessageDialog(
        "删除成功.",
        function: () => _getItemInfoList(),
      );
    } else {
      context.showMessageDialog(HttpConfig.message(resp) ?? "删除失败");
    }
  }

  void showEditBtnInfoDialog(BuildContext context, bool isAdd, {MainMenuItemResp? item}) async {
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
        DialogTextField(
            hintText: "请输入按钮 Name",
            initialText: item?.name ?? ""
        ),
        DialogTextField(
            hintText: "请输入跳转地址 Url",
            initialText: item?.url ?? ""
        ),
      ],
    );
    if (context.mounted) {
      _addBtnItem(result, context, isAdd, id: item?.id);
    }
  }

  void _addBtnItem(List<String>? result, BuildContext context, bool isAdd, {int? id}) {
    if (result == null) return;
    if (true != result.isNotEmpty) {
      context.showMessageDialog("请输入正确的按钮信息.");
      return;
    }
    if (result.length != 2) {
      context.showMessageDialog("请输入正确的按钮信息.");
      return;
    }
    var name = result[0];
    var url = result[1];
    if (name.isEmpty || url.isEmpty) {
      context.showMessageDialog("请输入正确的按钮信息.");
      return;
    }
    var data = {
      "name": name,
      "url": url,
    };
    if (isAdd) {
      _addItem(data, context);
    } else {
      data["id"] = "$id";
      _editItem(context, data);
    }
  }

  void _addItem(Map<String, String> info, BuildContext context) async {
    var respMap = await Http.post(
      HttpApi.addMainMenuItem,
      data: info,
      contentType: HttpContentType.formUrlencoded.type,
    );
    if (!context.mounted) return;
    if (HttpConfig.isOk(map: respMap)) {
      context.showMessageDialog("添加按钮信息成功.",
          function: () => _getItemInfoList());
    } else {
      context.showMessageDialog(
          HttpConfig.message(respMap) ?? "添加按钮信息失败");
    }
  }

  void _editItem(BuildContext context, Map<String, String> info) async {
    var resp = await Http.post(
      HttpApi.editMainMenuBtnInfo,
      data: info,
    );
    if (!context.mounted) return;
    if (HttpConfig.isOk(map: resp)) {
      context.showMessageDialog(
        "编辑成功.",
        function: () => _getItemInfoList(),
      );
    } else {
      context.showMessageDialog(HttpConfig.message(resp) ?? "编辑失败");
    }
  }
}
