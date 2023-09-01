import 'package:daystodieutils/module/n_http_request.dart';
import 'package:daystodieutils/net/entity/zombie_detail_resp.dart';
import 'package:daystodieutils/net/resp_factory.dart';
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:get/get.dart';

class GuideZombieController extends GetxController {
  static const String idContent = "idContent";

  String zombieName = "--";
  String zombieType = "--";
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

  void _initZombieListData() async {
    var id = Get.parameters["id"];
    if (id == null) {
      Get.context?.showMessageDialog("古神id为空, 获取失败.");
      return;
    }
    var respMap = NHttpRequest.getZombieDetail(id);
    var resp = RespFactory.parseObject(respMap, ZombieDetailResp());
    var data = resp.data;
    if (data == null) {
      Get.context?.showMessageDialog(resp.message ?? "获取详情失败.");
      return;
    }
    zombieName = data.name ?? "--";
    zombieType = data.zombieType ?? "--";
    zombieHp = data.zombieHp ?? "--";
    bootyList = data.bootyList ?? "--";
    corpseDrop = data.corpseDrop ?? "--";
    precautions = data.precautions ?? "--";
    raiders = data.raiders ?? "--";
    update([idContent]);
  }
}
