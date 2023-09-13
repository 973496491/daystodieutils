import '../core/safe_map.dart';

abstract class NRespCommon {

  T? parseObject<T>(dynamic data);
  List<T>? parseArray<T>(dynamic data);
}