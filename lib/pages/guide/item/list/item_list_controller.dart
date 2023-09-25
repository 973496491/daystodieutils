import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/config.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../module/entity/item_list_resp.dart';
import '../../../../net/n_http_request.dart';
import '../../../../net/n_resp_factory.dart';

class ItemListController extends GetxController {
  static const String idListView = "idListView";
  static const String keyStatus = "keyStatus";

  final PagingController<int, ItemListResp> pagingController =
      PagingController(firstPageKey: NHttpConfig.defaultPageIndex);

  String status = "${Config.itemStatusReviewed}";
  String? filterName;

  @override
  void onInit() {
    var mStatus = Get.parameters[keyStatus];
    if (mStatus !=  null) {
      status = mStatus;
    }
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
  }

  void _fetchPage(int pageKey) async {
    try {
      final newItems = await _getItemList(pageKey);
      final isLastPage = newItems.length < NHttpConfig.defaultPageSize;
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

  Future<List<ItemListResp>> _getItemList(int pageKey) async {
    var respMap = await NHttpRequest.getItemList(pageKey, status, name: filterName);
    var resp = NRespFactory.parseArray<ItemListResp>(respMap, ItemListResp());
    var data = resp.data;
    return data ?? [];
  }

  void toDetailPage(String? id, bool canEdit) async {
    if (id == null) return;
    var parameters = {
      "id": id,
      "canEdit": "$canEdit",
      keyStatus: status,
    };
    var result = await Get.toNamed(
      RouteNames.itemInfo,
      parameters: parameters,
    );
    "$result".logD();
    if (result != null) {
      if (true == result) {
        pagingController.refresh();
      }
    }
  }

  void showSearchDialog() async {
    var context = Get.context;
    final result = await showTextInputDialog(
      context: context!,
      title: "搜索",
      okLabel: "确定",
      cancelLabel: "取消",
      style: AdaptiveStyle.iOS,
      textFields: [
        const DialogTextField(
          hintText: "请输入名称, 留空搜索全部",
        ),
      ],
    );
    resetParams();
    filterName = result?[0];
    pagingController.refresh();
  }

  void resetParams() {
    filterName = null;
  }
}
