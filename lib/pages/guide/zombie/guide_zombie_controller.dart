import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GuideZombieController extends GetxController {

  static const String idContent = "idContent";

  String zombieName = "未知";
  String zombieType = "未知";
  String zombieHp = "0";
  String bootyList = "无"; // 掉落物
  String corpseDrop = "无"; // 尸体材料
  String precautions = "无"; // 注意事项
  String raiders = "无"; // 攻略

  @override
  void onReady() {
    super.onReady();
    _initZombieListData();
  }

  void _initZombieListData() {
    zombieName = "测试数据";
    zombieType = "BOSS";
    zombieHp = "60000";
    bootyList = "古神结晶, 死灵之书残页, 1级枪口蓝图";
    corpseDrop = "未知";
    precautions = "未知";
    raiders = "无";
    update([idContent]);
  }
}
