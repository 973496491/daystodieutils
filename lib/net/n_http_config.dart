class NHttpConfig {

  static const int _success = 0;

  static const String _testUrl = "http://localhost:7777/api";
  static const String _prodUrl = "http://123.207.77.55:7777/api";

  static const String baseUrl = _prodUrl;

  static bool isOk({Map<String, dynamic>? map, int? bizCode}) {
    if (null != bizCode) return bizCode == _success;
    if (map == null) return false;
    var code = map["code"];
    if (code == null) return false;
    return code == _success;
  }

  static String? message(Map<String, dynamic>? map) {
    if (map == null) return null;
    return map["message"];
  }

  static const Duration connectTimeout = Duration(seconds: 1000 * 10);
  static const Duration receiveTimeout = Duration(seconds: 1000 * 10);

  static const int defaultPageIndex = 1;
  static const int defaultPageSize = 20;
}
