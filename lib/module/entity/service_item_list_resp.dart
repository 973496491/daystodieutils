import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class ServiceItemListResp extends NRespCommon {
  ServiceItemListResp({
    this.id,
    this.name,
    this.thumbnailUrl,
  });

  int? id;
  String? name;
  String? thumbnailUrl;

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
      return ServiceItemListResp(
        id: map["id"].value,
        name: map["name"].value,
        thumbnailUrl: map["thumbnailUrl"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
