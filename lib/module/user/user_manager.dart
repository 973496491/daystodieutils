import 'package:daystodieutils/module/user/user_info.dart';

import '../../utils/sp_util.dart';

class UserManager {
  static const String _key = "UserInfo";

  static UserInfo getUserInfo() {
    var infoMap = SpUtil.getObject(_key);
    if (infoMap == null) return UserInfo();
    return UserInfo.formatMap(infoMap);
  }

  static void setToken(String? token) {
    UserInfo info = getUserInfo();
    info.token = token;
    SpUtil.putObject(_key, info);
  }

  static String? getToken() {
    var info = getUserInfo();
    return info.token;
  }
}
