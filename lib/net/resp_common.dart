import '../core/safe_map.dart';

abstract class RespCommon {

  T? parseObject<T>(dynamic data);
  List<T>? parseArray<T>(dynamic data);
}