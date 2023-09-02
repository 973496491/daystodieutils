import 'package:daystodieutils/net/http.dart';
import 'package:daystodieutils/net/n_http_content_type.dart';

import 'n_http_api.dart';

class NHttpRequest {
  static login(
    String username,
    String password,
  ) {
    return Http.post(
      NHttpApi.login,
      data: {"username": username, "password": password},
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

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
    return Http.post(
      NHttpApi.getZombieList,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 获取古神详情
  static getZombieDetail(dynamic id) async {
    var reqMap = {
      "id": "$id",
    };
    return Http.post(
      NHttpApi.getZombieDetail,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 更新古神详情
  static updateZombieDetail(
    int? id,
    String? zombieName,
    String? zombieType,
    String? zombieHp,
    String? bootyList,
    String? corpseDrop,
    String? precautions,
    String? raiders,
  ) async {
    var reqMap = <String, String>{};
    if (null != id) {
      reqMap["id"] = "$id";
    }
    if (true == zombieName?.isNotEmpty) {
      reqMap["name"] = "$zombieName";
    }
    if (true == zombieType?.isNotEmpty) {
      reqMap["zombieType"] = "$zombieType";
    }
    if (true == zombieHp?.isNotEmpty) {
      reqMap["zombieHp"] = "$zombieHp";
    }
    if (true == bootyList?.isNotEmpty) {
      reqMap["bootyList"] = "$bootyList";
    }
    if (true == corpseDrop?.isNotEmpty) {
      reqMap["corpseDrop"] = "$corpseDrop";
    }
    if (true == precautions?.isNotEmpty) {
      reqMap["precautions"] = "$precautions";
    }
    if (true == raiders?.isNotEmpty) {
      reqMap["raiders"] = "$raiders";
    }
    String url;
    if (id != null) {
      url = NHttpApi.updateZombieDetail;
    } else {
      url = NHttpApi.insertZombieDetail;
    }
    return Http.post(
      url,
      data: reqMap,
      contentType: NHttpContentType.applicationJson.type,
    );
  }

  static deleteZombieDetail(int? id) {
    var reqMap = <String, String>{"id": "${id}"};
    return Http.post(
      NHttpApi.deleteZombieDetail,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }
}
