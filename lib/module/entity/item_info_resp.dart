import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class ItemInfoResp extends NRespCommon {
  ItemInfoResp({
    this.id,
    this.name,
    this.getWay,
    this.introduction,
    this.imageUrl,
    this.thumbnailUrl,
  });

  int? id;
  String? name;
  String? getWay;
  String? introduction;
  String? imageUrl;
  String? thumbnailUrl;

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return ItemInfoResp(
        id: map["id"].value,
        name: map["name"].value,
        getWay: map["getWay"].value,
        introduction: map["introduction"].value,
        imageUrl: map["imageUrl"].value,
        thumbnailUrl: map["thumbnailUrl"].value,
      ) as T;
    } else {
      return null;
    }
  }

  @override
  List<T>? parseArray<T>(data) {
    // TODO: implement parseArray
    throw UnimplementedError();
  }
}
