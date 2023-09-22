import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class UploadImageResp extends NRespCommon {
  UploadImageResp({
    this.name,
    this.key,
    this.url,
    this.thumbnailUrl,
    this.error,
  });

  String? name;
  String? key;
  String? url;
  String? thumbnailUrl;
  String? error;

  @override
  List<T>? parseArray<T>(data) {
    return null;
  }

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return UploadImageResp(
        name: map["name"].value ?? "",
        key: map["key"].value ?? "",
        url: map["url"].value ?? "",
        thumbnailUrl: map["thumbnailUrl"].value ?? "",
        error: map["error"].value ?? "",
      ) as T;
    } else {
      return null;
    }
  }
}
