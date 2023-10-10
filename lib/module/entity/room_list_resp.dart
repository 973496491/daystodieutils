import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class RoomListResp extends NRespCommon {
  RoomListResp({
    this.id,
    this.name,
    this.roomNumber,
    this.roomUrl,
    this.roomIcon,
    this.desc,
  });

  int? id;
  String? name;
  String? roomNumber;
  String? roomUrl;
  String? roomIcon;
  String? desc;

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
      return RoomListResp(
        id: map["id"].value,
        name: map["name"].value,
        roomNumber: map["roomNumber"].value,
        roomUrl: map["roomUrl"].value,
        roomIcon: map["roomIcon"].value,
        desc: map["desc"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
