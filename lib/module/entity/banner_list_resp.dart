import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class BannerListEntity extends NRespCommon {
  BannerListEntity({
    this.id,
    this.imageUrl,
    this.target,
  });

  int? id;
  String? imageUrl;
  String? target;

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
      return BannerListEntity(
        id: map["id"].value,
        imageUrl: map["imageUrl"].value,
        target: map["target"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
