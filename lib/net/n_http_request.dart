import 'package:daystodieutils/net/http.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/net/n_http_content_type.dart';
import 'package:dio/dio.dart';

import 'n_http_api.dart';

class NHttpRequest {
  /// 登录
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
    String? iconUrl,
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
    if (true == iconUrl?.isNotEmpty) {
      reqMap["imageUrl"] = "$iconUrl";
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
    var reqMap = <String, String>{"id": "$id"};
    return Http.post(
      NHttpApi.deleteZombieDetail,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 获取cos临时密钥
  static getCosPrivateKey() {
    return Http.post(NHttpApi.getCosPrivateKey);
  }

  static uploadImage(
    String fileName,
    MultipartFile imageFile,
  ) {
    var reqMap = FormData.fromMap({
      "fileName": fileName,
      "file": imageFile,
    });
    return Http.postFile(NHttpApi.uploadImage, reqMap);
  }

  /// 查询道具列表
  static getItemList(
    int pageIndex,
    String status, {
    String? name,
  }) {
    var reqMap = <String, String>{
      "pageIndex": "$pageIndex",
      "status": status,
      "pageSize": "${NHttpConfig.defaultPageSize}"
    };
    if (name != null) {
      reqMap["name"] = name;
    }
    return Http.get(
      NHttpApi.getItemList,
      params: reqMap,
    );
  }

  /// 获取道具详情
  static getItemInfo(String id) {
    var reqMap = <String, String>{"id": "$id"};
    return Http.post(
      NHttpApi.getItemInfo,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 删除道具
  static deleteItem(String id) {
    var reqMap = <String, String>{"id": "$id"};
    return Http.post(
      NHttpApi.deleteItem,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 更新道具详情
  static updateItemInfo(
    int? id,
    String? itemName,
    String? getWay,
    String? introduction,
    String? iconUrl,
    String? thumbnailUrl,
  ) async {
    var reqMap = <String, String>{};
    if (null != id) {
      reqMap["id"] = "$id";
    }
    if (true == itemName?.isNotEmpty) {
      reqMap["name"] = "$itemName";
    }
    if (true == getWay?.isNotEmpty) {
      reqMap["getWay"] = "$getWay";
    }
    if (true == introduction?.isNotEmpty) {
      reqMap["introduction"] = "$introduction";
    }
    if (true == iconUrl?.isNotEmpty) {
      reqMap["imageUrl"] = "$iconUrl";
    }
    if (true == thumbnailUrl?.isNotEmpty) {
      reqMap["thumbnailUrl"] = "$thumbnailUrl";
    }
    String url;
    if (id != null) {
      url = NHttpApi.updateItemInfo;
    } else {
      url = NHttpApi.insertItemInfo;
    }
    return Http.post(
      url,
      data: reqMap,
      contentType: NHttpContentType.applicationJson.type,
    );
  }

  /// 查询道具列表
  static getServiceList(
    int pageIndex,
  ) {
    var reqMap = <String, String>{
      "pageIndex": "$pageIndex",
      "pageSize": "${NHttpConfig.defaultPageSize}"
    };
    return Http.get(
      NHttpApi.serviceList,
      params: reqMap,
    );
  }

  /// 通过道具审核
  static passItemReview(
    String id,
  ) async {
    var reqMap = <String, String>{"id": id};
    return Http.post(
      NHttpApi.reviewItemInfo,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 查询道具是否存在
  static getItemNameIsExist(
    String name,
  ) async {
    var reqMap = <String, String>{"name": name};
    return Http.post(
      NHttpApi.getItemNameIsExist,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 提交意见反馈
  static commitFeedback(
    String name,
    String message,
    String? contactInfo,
  ) async {
    var reqMap = <String, String>{
      "nickname": name,
      "message": message,
    };
    if (true == contactInfo?.isNotEmpty) {
      reqMap["contactInformation"] = contactInfo!;
    }
    return Http.post(
      NHttpApi.commitFeedback,
      data: reqMap,
      contentType: NHttpContentType.applicationJson.type,
    );
  }
}
