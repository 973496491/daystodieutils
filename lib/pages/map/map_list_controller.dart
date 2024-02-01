import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/module/entity/map_list_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapListController extends GetxController {
  static const String idListView = "idListView";

  List<MapListResp> itemList = [];

  @override
  void onReady() {
    super.onReady();
    _getItemInfoList();
  }

  void _getItemInfoList() async {
    var respMap = await NHttpRequest.getMapList();
    var resp = NRespFactory.parseArray<MapListResp>(respMap, MapListResp());
    var data = resp.data;
    if (NHttpConfig.isOk(bizCode: resp.code)) {
      itemList = data!;
    }
    update([idListView]);
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
    // if (context.mounted) {
    //   resetParams();
    //   zombieType = result?[0];
    //   zombieName = result?[1];
    //   pagingController.refresh();
    // }
  }

  void toDetailPage(String? imageUrl) async {
    if (imageUrl == null) return;
    var parameters = {
      "url": imageUrl,
    };
    Get.toNamed(
      RouteNames.mapBig,
      parameters: parameters,
    );
  }

  void addMapItem() {}
}
