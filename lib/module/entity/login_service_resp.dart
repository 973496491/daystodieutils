import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class LoginServiceResp extends NRespCommon {
  LoginServiceResp({
    this.token,
    this.key,
  });

  String? token;
  String? key;

  @override
  List<T>? parseArray<T>(data) {
    return null;
  }

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return LoginServiceResp(
        token: map["token"].value,
        key: map["key"].value,
      ) as T;
    } else {
      return LoginServiceResp() as T;
    }
  }
}
