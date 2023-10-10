import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/net/n_http_api.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_content_type.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../module/entity/whitelist_resp.dart';
import '../../net/http.dart';
import '../../net/n_resp_factory.dart';

class WhitelistController extends GetxController {
  static const String idListView = "idListView";
  static const int _pageSize = NHttpConfig.defaultPageSize;
  static const String _typeEdit = "edit";
  static const String _typeDelete = "_delete";

  final PagingController<int, WhiteListResp> pagingController =
      PagingController(firstPageKey: NHttpConfig.defaultPageIndex);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  void _fetchPage(int pageKey) async {
    try {
      final newItems = await _getWhiteList(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
      update([idListView]);
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<WhiteListResp>> _getWhiteList(int pageKey) async {
    var params = {
      "pageIndex": pageKey,
      "pageSize": _pageSize,
    };
    var respMap = await Http.get(NHttpApi.whitelist, params: params);
    var resp = NRespFactory.parseArray<WhiteListResp>(respMap, WhiteListResp());
    var data = resp.data;
    return data ?? [];
  }

  void showAddWhitelistDialog(BuildContext context) async {
    var canNext = await ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

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
    _addWhitelistItem(result);
  }

  void _addWhitelistItem(List<String>? result) {
    if (result == null) return;
    if (true != result.isNotEmpty) {
      Get.context?.showMessageDialog("请输入正确的白名单信息.");
      return;
    }
    if (result.length != 3) {
      Get.context?.showMessageDialog("请输入正确的白名单信息.");
      return;
    }
    var name = result[0];
    var author = result[1];
    var desc = result[2];
    if (name.isEmpty || author.isEmpty || desc.isEmpty) {
      Get.context?.showMessageDialog("请输入正确的白名单信息.");
      return;
    }
    var data = {
      "name": name,
      "author": author,
      "desc": desc,
    };
    _addWhitelist(data);
  }

  void _addWhitelist(Map<String, String> info) async {
    var respMap = await Http.post(
      NHttpApi.addWhitelist,
      data: info,
      contentType: NHttpContentType.applicationJson.type,
    );
    if (NHttpConfig.isOk(map: respMap)) {
      var result = await Get.context?.showMessageDialog("添加白名单成功.");
      if (result != null) {
        _fetchPage(NHttpConfig.defaultPageIndex);
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(respMap) ?? "添加白名单失败");
    }
  }

  void showEditDialog(BuildContext context, int? id) async {
    var canNext = await ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

    var key = await showConfirmationDialog(
      context: Get.context!,
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
          if (id == null) return;
          _deleteItem(id);
          break;
        }
      case _typeEdit: {
        Get.context?.showMessageDialog("开发中");
        break;
      }
    }
  }

  void _deleteItem(int id) async {
    var canNext = await ViewUtils.checkOptionPermissions(Get.context);
    if (!canNext) return;

    var reqMap = {"id": "$id"};
    var resp = await Http.post(
      NHttpApi.deleteWhitelist,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
    if (NHttpConfig.isOk(map: resp)) {
      var result = await Get.context?.showMessageDialog("删除成功.");
      if (result != null) {
        _fetchPage(NHttpConfig.defaultPageIndex);
      }
    } else {
      Get.context?.showMessageDialog(NHttpConfig.message(resp) ?? "删除失败");
    }
  }
}
