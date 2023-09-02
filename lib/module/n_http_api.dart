class NHttpApi {

  static const String _testUrl = "http://localhost:7777/api";
  static const String _prodUrl = "http://123.207.77.55:7777/api";

  static const String baseUrl = _prodUrl;

  /// 登录
  static const String login = "/users/login";

  /// 白名单列表
  static const String whitelist = "/config/whitelist";

  /// 添加白名单
  static const String addWhitelist = "/config/add/whitelist";

  /// 删除白名单
  static const String deleteWhitelist = "/config/delete/whitelist";

  /// 获取古神列表
  static const String getZombieList = "/info/getAllZombieList";

  /// 获取古神详情
  static const String getZombieDetail = "/info/getZombieInfo";

  /// 更新古神详情
  static const String updateZombieDetail = "/info/update/zombieInfo";

  /// 插入古神详情
  static const String insertZombieDetail = "/info/insert/zombieInfo";

  /// 插入古神详情
  static const String deleteZombieDetail = "/info/delete/zombieInfo";

  /// 获取所有主菜单按钮
  static const String getMainMenuItemList = "/config/mainMenuBtn";

  /// 添加主菜单按钮
  static const String addMainMenuItem = "/config/add/mainMenuBtn";

  /// 删除主菜单按钮
  static const String deleteMainMenuBtnInfo = "/config/delete/mainMenuBtn";

  /// 编辑主菜单按钮
  static const String editMainMenuBtnInfo = "/config/update/mainMenuBtn";
}
