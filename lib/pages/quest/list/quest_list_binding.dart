import 'package:daystodieutils/pages/quest/list/quest_list_controller.dart';
import 'package:get/get.dart';

class QuestListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestListController());
  }
}