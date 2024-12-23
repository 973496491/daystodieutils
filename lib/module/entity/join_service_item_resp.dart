import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class JoinServiceItemResp extends NRespCommon {
  JoinServiceItemResp({
    this.id,
    this.name,
    this.desc,
    this.qqRoom,
    this.qqRoomUrl,
    this.imageUrl,
    this.thumbnailUrl,
  });

  int? id;
  String? name;
  String? desc;
  String? qqRoom;
  String? qqRoomUrl;
  String? imageUrl;
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
      return JoinServiceItemResp(
        id: map["id"].value,
        name: map["name"].value,
        desc: map["desc"].value,
        qqRoom: map["qqRoom"].value,
        qqRoomUrl: map["qqRoomUrl"].value,
        imageUrl: map["imageUrl"].value,
        thumbnailUrl: map["thumbnailUrl"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
