import 'package:get/get.dart';

import 'quest_detail_controller.dart';

class QuestDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestDetailController());
  }
}