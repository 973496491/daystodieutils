class NHttpConfig {

  static const int _success = 0;

  static const String _testUrl = "http://127.0.0.1:8080/api";
  static const String _prodUrl = "https://www.lolko.xyz/api";

  // static const String baseUrl = _testUrl;
  static const String baseUrl = _prodUrl;

  static bool isOk({Map<String, dynamic>? map, int? bizCode}) {
    if (null != bizCode) return bizCode == _success;
    if (map == null) return false;
    var code = map["code"];
    if (code == null) return false;
    return code == _success;
  }

  static int? code(Map<String, dynamic>? map) {
    if (map == null) return null;
    return map["code"];
  }

  static String? message(Map<String, dynamic>? map) {
    if (map == null) return null;
    return map["message"];
  }

  static dynamic data(Map<String, dynamic>? map) {
    if (map == null) return null;
    return map["data"];
  }

  static const Duration connectTimeout = Duration(seconds: 1000 * 10);
  static const Duration receiveTimeout = Duration(seconds: 1000 * 10);

  static const int defaultPageIndex = 1;
  static const int defaultPageSize = 20;
}
