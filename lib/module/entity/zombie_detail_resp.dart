import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class ZombieDetailResp extends NRespCommon {
  ZombieDetailResp({
    this.id,
    this.name,
    this.zombieType,
    this.zombieHp,
    this.bootyList,
    this.corpseDrop,
    this.precautions,
    this.raiders,
    this.imageUrl,
  });

  int? id;
  String? name;
  String? zombieType;
  String? zombieHp;
  String? bootyList;
  String? corpseDrop;
  String? precautions;
  String? raiders;
  String? imageUrl;

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return ZombieDetailResp(
        id: map["id"].value,
        name: map["name"].value,
        zombieType: map["zombieType"].value,
        zombieHp: map["zombieHp"].value,
        bootyList: map["bootyList"].value,
        corpseDrop: map["corpseDrop"].value,
        precautions: map["precautions"].value,
        raiders: map["raiders"].value,
        imageUrl: map["imageUrl"].value,
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
