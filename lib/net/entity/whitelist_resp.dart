import 'package:daystodieutils/core/safe_map.dart';
import 'package:daystodieutils/net/resp_common.dart';

class WhiteListResp extends RespCommon {
  WhiteListResp({this.name, this.author, this.desc});

  String? name;
  String? author;
  String? desc;

  @override
  List<T>? parseArray<T>(data) {
    if (data is List<dynamic>) {
      var list = <T>[];
      for (var value in data.map((e) => parseObject(e))) {
        list.add(value);
      }
      return list;
    } else {
      return null;
    }
  }

  @override
  T? parseObject<T>(data) {
    if (data != null) {
      var map = SafeMap(data);
      return WhiteListResp(
        name: map["name"].value,
        author: map["author"].value,
        desc: map["desc"].value,
      ) as T;
    } else {
      return null;
    }
  }
}
