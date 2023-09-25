class Config {
  static bool isRelease = const bool.fromEnvironment("dart.vm.product");


  static String cosRegion = "ap-shanghai";
  static String cosBucketName = "jiurizhipeizhe-1300866055";
  static String cosImagePath = "Info_Image/";

  /// 物品未审核
  static int itemStatusUnreview = 0;
  /// 物品已审核
  static int itemStatusReviewed = 1;
}