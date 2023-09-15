import 'package:daystodieutils/net/n_http_config.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../module/entity/item_list_resp.dart';
import '../../../../net/n_http_request.dart';
import '../../../../net/n_resp_factory.dart';

class ItemListController extends GetxController {
  static const String idListView = "idListView";

  final PagingController<int, ItemListResp> pagingController =
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
    var respMap = await NHttpRequest.getItemList();
    var resp = NRespFactory.parseArray<ItemListResp>(respMap, ItemListResp());
    var data = resp.data;
    return data ?? [];
  }

  toDetailPage(String s, bool bool) {}
}
