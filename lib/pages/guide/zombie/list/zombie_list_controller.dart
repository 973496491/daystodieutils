import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/module/n_http_request.dart';
import 'package:daystodieutils/net/entity/zombie_list_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/resp_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ZombieListController extends GetxController {
  static const String idListView = "idListView";

  int _pageIndex = NHttpConfig.defaultPageIndex;
  String? zombieType;
  String? zombieName;
  bool isRefresh = true;

  List<ZombieListResp> zombieList = [];

  @override
  void onReady() {
    super.onReady();
    getZombieList();
  }

  void getZombieList() async {
    var respMap = await NHttpRequest.getZombieList(_pageIndex, zombieType, zombieName);
    var resp =
        RespFactory.parseArray<ZombieListResp>(respMap, ZombieListResp());
    var data = resp.data;
    if (isRefresh) {
      zombieList = data ?? [];
    } else {
      if (NHttpConfig.isOk(bizCode: resp.code)) {
        _pageIndex++;
        if (true == data?.isNotEmpty) {
          zombieList.addAll(data!);
        }
      }
    }
    update([idListView]);
  }

  void onRefresh() {
    resetParams();
    getZombieList();
  }

  void onLoadMore() {
    _pageIndex++;
    isRefresh = false;
    getZombieList();
  }

  void resetParams() {
    _pageIndex = 0;
    zombieType = null;
    zombieName = null;
    isRefresh = true;
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
      getZombieList();
    }
  }

  void toDetailPage(int? id, bool canEdit) {
    if (id == null) return;
    var parameters = {
      "id": "$id",
    };
    Get.toNamed(
      RouteNames.guildZombie,
      parameters: parameters,
    );
  }
}
