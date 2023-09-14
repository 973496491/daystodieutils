import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../module/entity/zombie_list_resp.dart';

class ZombieListController extends GetxController {
  static const String idListView = "idListView";
  static const int _pageSize = NHttpConfig.defaultPageSize;

  String? zombieType;
  String? zombieName;

  final PagingController<int, ZombieListResp> pagingController =
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
      final newItems = await _getZombieList(pageKey);
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

  Future<List<ZombieListResp>> _getZombieList(int pageKey) async {
    var respMap =
        await NHttpRequest.getZombieList(pageKey, zombieType, zombieName);
    var resp = NRespFactory.parseArray<ZombieListResp>(respMap, ZombieListResp());
    var data = resp.data;
    return data ?? [];
  }

  void resetParams() {
    zombieType = null;
    zombieName = null;
  }

  void showSearchDialog(BuildContext context) async {
    final result = await showTextInputDialog(
      context: context,
      title: "搜索",
      okLabel: "确定",
      cancelLabel: "取消",
      style: AdaptiveStyle.iOS,
      textFields: [
        const DialogTextField(
          hintText: "请输入名称, 留空搜索全部",
        ),
        const DialogTextField(
          hintText: "请输入类型, 留空搜索全部",
        ),
      ],
    );
    if (context.mounted) {
      resetParams();
      zombieType = result?[0];
      zombieName = result?[1];
      pagingController.refresh();
    }
  }

  void toDetailPage(String? id, bool canEdit) {
    if (id == null) return;
    var parameters = {
      "id": id,
      "canEdit": "$canEdit",
    };
    Get.toNamed(
      RouteNames.guildZombie,
      parameters: parameters,
    )?.then((value) {
      if (value != null) {
        var result = value as Map<String, dynamic>;
        var needReload = result["needReload"];
        if (true == needReload) {
          pagingController.refresh();
        }
      }
    });
  }
}
