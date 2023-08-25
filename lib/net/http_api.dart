class HttpApi {

  static const String _testUrl = "http://localhost:7777/api";
  static const String _prodUrl = "http://123.207.77.55:7777/api";

  static const String baseUrl = _testUrl;

  /// 登录
  static const String login = "/users/login";

  /// 白名单列表
  static const String whitelist = "/config/whitelist";

  /// 添加白名单
  static const String addWhitelist = "/config/add/whitelist";
}
