class NHttpApi {

  /// 登录
  static const String login = "/users/login";

  /// 服务器登录
  static const String serviceLogin = "/service/login";

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

  /// 查询招人服务器信息
  static const String serviceList = "/info/getJoinServiceList";

  /// 查询单机QQ群列表
  static const String qqRoomList = "/config/getQQRoomList";

  /// 获取腾讯云COS临时密钥
  static const String getCosPrivateKey = "/file/getCosTmpSecretId";

  /// 上传图片
  static const String uploadImage = "/file/uploadImage";
  static const String uploadImageNotToken = "/file/uploadImageNotToken";

  /// 上传图片
  static const String uploadServiceImage = "/file/uploadServiceImage";

  /// 查询道具列表
  static const String getItemList = "/info/getItemList";

  /// 查询任务列表
  static const String getQuestList = "/quest/getItemList";

  /// 查询道具详情
  static const String getItemInfo = "/info/getItemInfo";

  /// 查询QQ群详情
  static const String getRoomItemInfo = "/config/getRoomItemInfo";

  /// 查询任务详情
  static const String getQuestDetail = "/quest/getItemInfo";

  /// 删除道具
  static const String deleteItem = "/info/deleteItemInfo";

  /// 删除道具
  static const String deleteRoomItem = "/config/deleteRoomItem";

  /// 删除任务
  static const String deleteQuest = "/quest/deleteItemInfo";

  /// 更新道具
  static const String updateItemInfo = "/info/updateItemInfo";

  /// 更新道具
  static const String updateQQRoomItem = "/config/updateQQRoomItem";

  /// 更新任务信息
  static const String updateQuestInfo = "/quest/updateItemInfo";

  /// 插入道具
  static const String insertItemInfo = "/info/insertItemInfo";

  /// 插入QQ群信息
  static const String insertQQRoomItem = "/config/insertQQRoomItem";

  /// 插入任务信息
  static const String insertQuestInfo = "/quest/insertItemInfo";

  /// 审核道具
  static const String reviewItemInfo = "/info/reviewItemInfo";

  /// 查询道具是否存在
  static const String getItemNameIsExist = "/info/getItemNameIsExist";

  /// 查询群号是否存在
  static const String checkRoomNotExist = "/config/checkRoomNotExist";

  /// 查询任务是否存在
  static const String checkItemNotExist = "/quest/checkItemNotExist";

  /// 提交意见反馈
  static const String commitFeedback = "/users/addFeedback";

  /// 查询服务器道具列表
  static const String getServiceItemList = "/service/getItemList";

  /// 查询服务器道具详情
  static const String getServiceItemInfo = "/service/getItemInfo";

  /// 删除服务器道具
  static const String deleteServiceItem = "/service/deleteItemInfo";

  /// 更新道具
  static const String updateServiceItemInfo = "/service/updateItemInfo";

  /// 插入道具
  static const String insertServiceItemInfo = "/service/insertItemInfo";

  /// 获取道具Id列表
  static const String getItemIds = "/info/getItemIds";
}
