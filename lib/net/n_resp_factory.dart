import 'package:daystodieutils/core/safe_map.dart';
import 'package:daystodieutils/net/base_resp.dart';

import 'n_resp_common.dart';

class NRespFactory {
  static BaseResp<T?> parseObject<T extends NRespCommon>(Map<String, dynamic> respMap, T t) {
    var map = SafeMap(respMap);
    return BaseResp(
      map["code"].value ?? -1,
      map["message"].value,
      t.parseObject<T>(map["data"].value),
    );
  }

  static BaseResp<List<T>?> parseArray<T extends NRespCommon>(Map<String, dynamic> respMap, T t) {
    var map = SafeMap(respMap);
    return BaseResp(
      map["code"].value ?? -1,
      map["message"].value,
      t.parseArray<T>(map["data"].value),
    );
  }
}
