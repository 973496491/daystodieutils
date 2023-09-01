import 'package:daystodieutils/net/http.dart';
import 'package:daystodieutils/net/http_content_type.dart';

import 'http_api.dart';

class NHttpRequest {
  /// 获取古神列表
  static getZombieList(
    dynamic pageIndex,
    dynamic zombieType,
    dynamic zombieName,
  ) async {
    var reqMap = <String, dynamic>{
      "pageIndex": "$pageIndex",
      "pageSize": 20,
    };
    if (zombieType != null) {
      reqMap["zombieType"] = zombieType;
    }
    if (zombieName != null) {
      reqMap["zombieName"] = zombieName;
    }
    return Http.post(HttpApi.getZombieList, data: reqMap);
  }

  /// 获取古神详情
  static getZombieDetail(dynamic id) async {
    var reqMap = {
      "id": "$id",
    };
    return Http.post(
      HttpApi.getZombieDetail,
      data: reqMap,
      contentType: HttpContentType.formUrlencoded.type,
    );
  }
}
