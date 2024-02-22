import 'package:daystodieutils/module/user/user_manager.dart';
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

  /// 服务器登录
  static serviceLogin(
    String username,
    String password,
  ) {
    return Http.post(
      NHttpApi.serviceLogin,
      data: {
        "username": username,
        "password": password,
      },
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
    MultipartFile imageFile, {
    bool needToken = true,
  }) {
    var reqMap = FormData.fromMap({
      "fileName": fileName,
      "file": imageFile,
    });
    String url;
    if (needToken) {
      url = NHttpApi.uploadImage;
    } else {
      url = NHttpApi.uploadImageNotToken;
    }
    return Http.postFile(url, reqMap);
  }

  static uploadServiceImage(
    String fileName,
    String serviceToken,
    MultipartFile imageFile,
  ) {
    var reqMap = FormData.fromMap({
      "fileName": fileName,
      "serviceToken": serviceToken,
      "file": imageFile,
    });
    return Http.postFile(NHttpApi.uploadServiceImage, reqMap);
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

  /// 查询任务列表
  static getQuestList(
    int pageIndex, {
    String? name,
  }) {
    var reqMap = <String, String>{
      "pageIndex": "$pageIndex",
      "pageSize": "${NHttpConfig.defaultPageSize}"
    };
    if (name != null) {
      reqMap["name"] = name;
    }
    return Http.get(
      NHttpApi.getQuestList,
      params: reqMap,
    );
  }

  /// 获取道具详情
  static getItemInfo(String id) {
    var reqMap = <String, String>{"id": id};
    return Http.post(
      NHttpApi.getItemInfo,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 获取QQ群详情
  static getRoomItemInfo(String id) {
    var reqMap = <String, String>{"id": id};
    return Http.get(
      NHttpApi.getRoomItemInfo,
      params: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 获取任务详情
  static getQuestDetail(String id) {
    var reqMap = <String, String>{"id": id};
    return Http.post(
      NHttpApi.getQuestDetail,
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

  /// 删除QQ群
  static deleteRoomItem(String id) {
    var reqMap = <String, String>{"id": id};
    return Http.post(
      NHttpApi.deleteRoomItem,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 删除任务
  static deleteQuest(String id) {
    var reqMap = <String, String>{
      "id": id,
    };
    return Http.post(
      NHttpApi.deleteQuest,
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

  /// 更新任务详情
  static updateQuestInfo(
    String? id,
    String name,
    String? getWay,
    String? workstation,
    String? recipes,
    String? introduction,
    String? raiders,
    String? imageUrl,
  ) async {
    var reqMap = <String, String>{
      "name": name,
    };
    if (null != id) {
      reqMap["id"] = "$id";
    }
    if (true == imageUrl?.isNotEmpty) {
      reqMap["imageUrl"] = imageUrl!;
    }
    if (true == getWay?.isNotEmpty) {
      reqMap["getWay"] = getWay!;
    }
    if (true == workstation?.isNotEmpty) {
      reqMap["workstation"] = workstation!;
    }
    if (true == recipes?.isNotEmpty) {
      reqMap["recipes"] = recipes!;
    }
    if (true == introduction?.isNotEmpty) {
      reqMap["introduction"] = introduction!;
    }
    if (true == raiders?.isNotEmpty) {
      reqMap["raiders"] = raiders!;
    }
    String url;
    if (id != null) {
      url = NHttpApi.updateQuestInfo;
    } else {
      url = NHttpApi.insertQuestInfo;
    }
    return Http.post(
      url,
      data: reqMap,
      contentType: NHttpContentType.applicationJson.type,
    );
  }

  /// 更新QQ群详情
  static updateQQRoomItemInfo(
    int? id,
    String name,
    String roomNumber,
    String roomUrl,
    String? roomIcon,
    String? desc,
  ) async {
    var reqMap = <String, String>{
      "name": name,
      "roomNumber": roomNumber,
      "roomUrl": roomUrl,
    };
    if (null != id) {
      reqMap["id"] = "$id";
    }
    if (true == roomIcon?.isNotEmpty) {
      reqMap["roomIcon"] = roomIcon!;
    }
    if (true == desc?.isNotEmpty) {
      reqMap["desc"] = desc!;
    }
    String url;
    if (id != null) {
      url = NHttpApi.updateQQRoomItem;
    } else {
      url = NHttpApi.insertQQRoomItem;
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

  /// 查询QQ群列表
  static getQQRoomList(
    int pageIndex,
  ) {
    var reqMap = <String, String>{
      "pageIndex": "$pageIndex",
      "pageSize": "${NHttpConfig.defaultPageSize}"
    };
    return Http.get(
      NHttpApi.qqRoomList,
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

  /// 查询群是否存在
  static getRoomNumberIsExist(
    String roomNumber,
  ) async {
    var reqMap = <String, String>{"roomNumber": roomNumber};
    return Http.post(
      NHttpApi.checkRoomNotExist,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 查询任务是否存在
  static checkItemNotExist(
    String name,
  ) async {
    var reqMap = <String, String>{
      "name": name,
    };
    return Http.post(
      NHttpApi.checkItemNotExist,
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

  /// 查询服务器道具列表
  static getServiceItemList(
    int pageIndex,
    String serviceKey, {
    String? name,
  }) {
    var reqMap = <String, String>{
      "pageIndex": "$pageIndex",
      "key": serviceKey,
      "pageSize": "${NHttpConfig.defaultPageSize}"
    };
    if (name != null) {
      reqMap["name"] = name;
    }
    return Http.post(
      NHttpApi.getServiceItemList,
      params: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 获取服务器道具详情
  static getServiceItemInfo(String id) {
    var reqMap = <String, String>{"id": id};
    return Http.post(
      NHttpApi.getServiceItemInfo,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 删除服务器道具
  static deleteServiceItem(
    String id,
    String? serviceToken,
  ) {
    var reqMap = <String, String>{
      "id": id,
    };
    if (null != serviceToken) {
      reqMap["serviceToken"] = serviceToken;
    }
    return Http.post(
      NHttpApi.deleteServiceItem,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 更新服务器道具详情
  static updateServiceItemInfo(
    int? id,
    String? serviceToken,
    String? itemName,
    String? getWay,
    String? introduction,
    String? iconUrl,
    String? thumbnailUrl,
    String? key,
  ) async {
    var reqMap = <String, String>{};
    if (null != serviceToken) {
      reqMap["serviceToken"] = serviceToken;
    }
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
    if (true == key?.isNotEmpty) {
      reqMap["key"] = "$key";
    }
    String url;
    if (id != null) {
      url = NHttpApi.updateServiceItemInfo;
    } else {
      url = NHttpApi.insertServiceItemInfo;
    }
    return Http.post(
      url,
      data: reqMap,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 查询道具id
  static getItemIds(
    String name,
  ) {
    var reqMap = <String, String>{
      "name": name,
    };
    return Http.get(
      NHttpApi.getItemIds,
      params: reqMap,
    );
  }

  /// 获取全景地图列表
  static getMapList() async {
    return Http.get(
      NHttpApi.getPanoramicMapList,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }

  /// 提交定制
  static commitCustomization(
      String name,
      String? desc,
      String contact,
      int type,
      String typeDesc,
  ) async {
    var reqMap = <String, String>{
      "name": name,
      "contact": contact,
      "type": "$type",
      "typeDesc": typeDesc,
    };
    if (true == desc?.isNotEmpty) {
      reqMap["desc"] = desc!;
    }
    return Http.post(
      NHttpApi.commitCustomization,
      data: reqMap,
      contentType: NHttpContentType.applicationJson.type,
    );
  }

  /// 获取首页banner
  static getBannerList() async {
    return Http.get(
      NHttpApi.indexBanner,
      contentType: NHttpContentType.formUrlencoded.type,
    );
  }
}