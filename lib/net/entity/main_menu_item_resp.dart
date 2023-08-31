import 'package:daystodieutils/core/safe_map.dart';
import 'package:daystodieutils/net/resp_common.dart';

class MainMenuItemResp extends RespCommon {
  MainMenuItemResp({this.id, this.name, this.url});

  int? id;
  String? name;
  String? url;

  @override
  List<T>? parseArray<T>(data) {
    if (data is List<dynamic>) {
      var list = <T>[];
      for (var value in data.map((e) => parseObject(e))) {
        list.add(value);
      }
      return list;
    } else {
      return null;
    }
  }

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return MainMenuItemResp(
        id: map["id"].value,
        name: map["name"].value,
        url: map["url"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
