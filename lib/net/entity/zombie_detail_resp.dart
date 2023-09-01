import 'package:daystodieutils/core/safe_map.dart';
import 'package:daystodieutils/net/resp_common.dart';

class ZombieDetailResp extends RespCommon {
  ZombieDetailResp({
    this.id,
    this.name,
    this.zombieType,
    this.zombieHp,
    this.bootyList,
    this.corpseDrop,
    this.precautions,
    this.raiders,
    this.imageKey,
  });

  int? id;
  String? name;
  String? zombieType;
  String? zombieHp;
  String? bootyList;
  String? corpseDrop;
  String? precautions;
  String? raiders;
  String? imageKey;

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
        imageKey: map["imageKey"].value,
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
