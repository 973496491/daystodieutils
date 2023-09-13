import 'package:daystodieutils/core/safe_map.dart';

import '../../net/n_resp_common.dart';

class LoginResp extends NRespCommon {
  LoginResp({this.token});

  String? token;

  @override
  List<T>? parseArray<T>(data) {
    return null;
  }

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return LoginResp(token: map["token"].value ?? "") as T;
    } else {
      return LoginResp(token: null) as T;
    }
  }
}
