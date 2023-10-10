import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/module/entity/quest_list_resp.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class QuestListController extends GetxController {
  static const String idListView = "idListView";

  final PagingController<int, QuestListResp> pagingController =
      PagingController(firstPageKey: NHttpConfig.defaultPageIndex);

  String? filterName;

  @override
  void onInit() {
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

  Future<List<QuestListResp>> _getItemList(int pageKey) async {
    var respMap = await NHttpRequest.getQuestList(pageKey, name: filterName);
    var resp = NRespFactory.parseArray(respMap, QuestListResp());
    var data = resp.data;
    return data ?? [];
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

  void toDetailPage(int? id) async {
    var parameters = <String, String>{};
    if (id != null) {
      parameters["id"] = "$id";
    }
    var result = await Get.toNamed(
      RouteNames.questDetail,
      parameters: parameters,
    );
    "questDetail page return: $result".logD();
    if (result != null) {
      if (true == result) {
        pagingController.refresh();
      }
    }
  }
}
