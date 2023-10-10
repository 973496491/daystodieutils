import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class QuestDetailResp extends NRespCommon {
  QuestDetailResp({
    this.id,
    this.name,
    this.imageUrl,
    this.getWay,
    this.workstation,
    this.recipes,
    this.introduction,
  });

  int? id;
  String? name;
  String? imageUrl;
  String? getWay;
  String? workstation;
  String? recipes;
  String? introduction;

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return QuestDetailResp(
        id: map["id"].value,
        name: map["name"].value,
        imageUrl: map["imageUrl"].value,
        getWay: map["getWay"].value,
        workstation: map["workstation"].value,
        recipes: map["recipes"].value,
        introduction: map["introduction"].value,
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
