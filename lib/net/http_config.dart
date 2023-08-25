class HttpConfig {
  static const int _success = 0;

  static bool isOk(Map<String, dynamic>? map) {
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
}
