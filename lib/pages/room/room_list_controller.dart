import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/module/entity/room_list_resp.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:daystodieutils/net/n_resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

class RoomListController extends GetxController {
  static const String idListView = "idListView";
  static const String idJoin = "idJoin";
  static const String idEdit = "idEdit";

  final PagingController<int, RoomListResp> pagingController =
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
      final newItems = await _getRoomList(pageKey);
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

  Future<List<RoomListResp>> _getRoomList(int pageKey) async {
    var respMap = await NHttpRequest.getQQRoomList(pageKey);
    "map: $respMap".logI();
    var resp = NRespFactory.parseArray(respMap, RoomListResp());
    var data = resp.data;
    return data ?? [];
  }

  onItemClick(int? id, String? url) async {
    if (id == null) return;
    var list = <ListDialogEntity>[];
    list.add(ListDialogEntity("加入", idJoin));
    if (UserManager.hasToken()) {
      list.add(ListDialogEntity("编辑", idEdit));
    }
    var result = await Get.context?.showListDialog(list);
    switch (result) {
      case idJoin:
        {
          if (url != null) {
            var uri = Uri.parse(url);
            launchUrl(uri, mode: LaunchMode.inAppWebView);
          }
          break;
        }
      case idEdit:
        {
          addRoom(id);
        }
        break;
    }
  }

  void addRoom(int? id) async {
    var parameters = <String, String>{};
    if (id != null) {
      parameters["id"] = "$id";
    }
    var result = await Get.toNamed(RouteNames.addRoom, parameters: parameters);
    if (result != null) {
      if (true == result) {
        pagingController.refresh();
      }
    }
  }
}
