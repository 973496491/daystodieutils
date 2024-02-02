import 'dart:ui';

import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class MapBigController extends GetxController {
  static const String idRootView = "idRootView";

  String imageUrl = "";
  bool isFullScreen = false;
  double? defaultScale;

  PhotoViewController controller = PhotoViewController();

  @override
  void onReady() {
    super.onReady();
    _initInfo();
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }

  void _initInfo() {
    var imageUrl = Get.parameters["url"];
    if (imageUrl != null) {
      this.imageUrl = imageUrl;
      "imageUrl: $imageUrl".logI();
      update([idRootView]);
    }
  }

  void changeFullScreen(bool isFullScreen) {
    "isFullScreen:$isFullScreen".logI();
    this.isFullScreen = isFullScreen;
    update([idRootView]);
  }

  void zoomIn() {
    defaultScale ??= controller.scale ?? 0.0;
    var scale = controller.scale ?? 0.0;
    if (scale + 0.1 >= defaultScale! + 1.0) {
      controller.scale = defaultScale! + 1.0;
    } else {
      controller.scale = controller.scale! + 0.1;
    }
  }

  void zoomOut() {
    defaultScale ??= controller.scale ?? 0.0;
    var scale = controller.scale ?? 0.0;
    if (scale - 0.1 <= defaultScale!) {
      controller.scale = defaultScale;
      changeFullScreen(false);
    } else {
      controller.scale = controller.scale! - 0.1;
    }
  }
}
