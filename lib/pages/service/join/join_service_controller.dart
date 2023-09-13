import 'package:daystodieutils/net/n_http_api.dart';
import 'package:daystodieutils/net/http.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../module/entity/join_service_item_resp.dart';
import '../../../net/n_resp_factory.dart';

class JoinServiceController extends GetxController {

  static const String idListView = "idListView";

  static const int _pageSize = NHttpConfig.defaultPageSize;
  
  List<JoinServiceItemResp> itemList = [];

  final PagingController<int, JoinServiceItemResp> pagingController =
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

  Future<List<JoinServiceItemResp>> _getWhiteList(int pageKey) async {
    var params = {
      "pageIndex": pageKey,
      "pageSize": _pageSize,
    };
    var respMap = await Http.get(NHttpApi.whitelist, params: params);
    var resp = NRespFactory.parseArray<JoinServiceItemResp>(respMap, JoinServiceItemResp());
    var data = resp.data;
    return data ?? [];
  }
}