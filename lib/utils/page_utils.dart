import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_request.dart';
import 'package:get/get.dart';

import 'dialog_ext.dart';

class PageUtils {
  static void showItemDetailPageDialog(List<String> array) async {
    if (array.isEmpty) return;
    var actions = array.map((e) => ListDialogEntity(e, e)).toList();
    var result = await Get.context?.showListDialog(actions);
    if (result == null) return;
    var respMap = await NHttpRequest.getItemIds(result);
    if (NHttpConfig.isOk(map: respMap)) {
      try {
        var data = NHttpConfig.data(respMap);
        var id = (data as List)[0];
        if (id == null) return;
        var parameters = {
          "id": "$id",
          "canEdit": "${false}",
        };
        Get.toNamed(RouteNames.itemInfo, parameters: parameters);
      } catch (ex) {
        ex.printError();
      }
    } else {
      var msg = NHttpConfig.message(respMap);
      Get.context?.showMessageDialog(msg);
    }
  }
}
