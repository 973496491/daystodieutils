import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../module/entity/join_service_item_resp.dart';
import '../../../net/n_resp_factory.dart';

class JoinServiceController extends GetxController {
  static const String idListView = "idListView";

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
      final newItems = await _getServiceList(pageKey);
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

  Future<List<JoinServiceItemResp>> _getServiceList(int pageKey) async {
    var respMap = await NHttpRequest.getServiceList(pageKey);
    var resp = NRespFactory.parseArray<JoinServiceItemResp>(
        respMap, JoinServiceItemResp());
    var data = resp.data;
    return data ?? [];
  }
}
