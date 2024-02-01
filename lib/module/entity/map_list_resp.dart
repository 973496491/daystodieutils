import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class MapListResp extends NRespCommon {
  MapListResp({
    this.id,
    this.name,
    this.imageUrl,
  });

  int? id;
  String? name;
  String? imageUrl;

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
      return MapListResp(
        id: map["id"].value,
        name: map["name"].value,
        imageUrl: map["imageUrl"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
