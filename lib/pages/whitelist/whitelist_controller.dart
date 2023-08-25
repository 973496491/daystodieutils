import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/http_api.dart';
import 'package:daystodieutils/net/http_config.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../net/entity/whitelist_resp.dart';
import '../../net/http.dart';
import '../../net/resp_factory.dart';

class WhitelistController extends GetxController {
  static const String idListView = "idListView";

  List<WhiteListResp> whitelist = [];

  @override
  void onReady() {
    super.onReady();
    getWhiteList();
  }

  void getWhiteList() async {
    var respMap = await Http.get(HttpApi.whitelist);
    var resp = RespFactory.parseArray<WhiteListResp>(respMap, WhiteListResp());
    var data = resp.data;
    if (true == data?.isNotEmpty) {
      whitelist = data!;
      update([idListView]);
    }
  }

  void showAddWhitelistDialog(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: "添加白名单",
      okLabel: "添加",
      cancelLabel: "取消",
      style: AdaptiveStyle.iOS,
      textFields: [
        const DialogTextField(
          hintText: "请输入ModInfo Name",
        ),
        const DialogTextField(
          hintText: "请输入ModInfo Author",
        ),
        const DialogTextField(
          hintText: "请输入Mod描述",
        ),
      ],
    );
    if (context.mounted) {
      _addWhitelistItem(result, context);
    }
  }

  void _addWhitelistItem(List<String>? result, BuildContext context) {
    if (result == null) return;
    if (true != result.isNotEmpty) {
      context.showMessageDialog("请输入正确的白名单信息.");
      return;
    }
    if (result.length != 3) {
      context.showMessageDialog("请输入正确的白名单信息.");
      return;
    }
    var name = result[0];
    var author = result[1];
    var desc = result[2];
    if (name.isEmpty || author.isEmpty || desc.isEmpty) {
      context.showMessageDialog("请输入正确的白名单信息.");
      return;
    }
    var data = {
      "name": name,
      "author": author,
      "desc": desc,
    };
    _addWhitelist(data, context);
  }

  void _addWhitelist(Map<String, String> info, BuildContext context) async {
    var respMap = await Http.post(HttpApi.addWhitelist, data: info);
    if (!context.mounted) return;
    if (HttpConfig.isOk(respMap)) {
      context.showMessageDialog("添加白名单成功.", function: () => getWhiteList());
    } else {
      context.showMessageDialog(HttpConfig.message(respMap) ?? "添加白名单失败");
    }
  }
}
