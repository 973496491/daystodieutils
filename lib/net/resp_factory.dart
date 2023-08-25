import 'package:daystodieutils/core/safe_map.dart';
import 'package:daystodieutils/net/base_resp.dart';
import 'package:daystodieutils/net/resp_common.dart';

class RespFactory {
  static BaseResp<T?> parseObject<T extends RespCommon>(Map<String, dynamic> resp, T t) {
    var map = SafeMap(resp);
    return BaseResp(
      map["code"].value ?? -1,
      map["message"].value,
      t.parseObject<T>(map["data"].value),
    );
  }

  static BaseResp<List<T>?> parseArray<T extends RespCommon>(Map<String, dynamic> resp, T t) {
    var map = SafeMap(resp);
    return BaseResp(
      map["code"].value ?? -1,
      map["message"].value,
      t.parseArray<T>(map["data"].value),
    );
  }
}
