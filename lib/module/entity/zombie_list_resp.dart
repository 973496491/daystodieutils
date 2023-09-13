import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class ZombieListResp extends NRespCommon {
  ZombieListResp({
    this.id,
    this.zombieType,
    this.zombieName,
    this.zombieHp,
  });

  int? id;
  String? zombieType;
  String? zombieName;
  String? zombieHp;

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
      return ZombieListResp(
        id: map["id"].value,
        zombieType: map["zombieType"].value,
        zombieName: map["zombieName"].value,
        zombieHp: map["zombieHp"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
