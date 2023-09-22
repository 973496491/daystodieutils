import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/pages/login/login_controller.dart';
import 'package:daystodieutils/pages/index_controller.dart' as mic;
import 'package:daystodieutils/utils/dialog_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends GetView<mic.IndexController> {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<mic.IndexController>(builder: (_) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "常用",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      _optionWidget(
                        "物品图鉴   ",
                        Icons.backup_table,
                        () => Get.toNamed(RouteNames.guildItemList),
                        "古神图鉴   ",
                        Icons.join_inner_outlined,
                        () => Get.toNamed(RouteNames.guildZombieList),
                      ),
                      _optionWidget(
                        "任务攻略   ",
                        Icons.question_answer_outlined,
                        () => Get.context?.showMessageDialog("敬请期待"),
                        "我要联机   ",
                        Icons.add_home_outlined,
                        () => Get.toNamed(RouteNames.joinServicePage),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "管理员功能",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      _optionWidget(
                        "管理员登录",
                        Icons.manage_accounts,
                        () => _loginController().showLoginDialog(context),
                        "更多功能   ",
                        Icons.question_answer_outlined,
                        () => Get.context?.showMessageDialog("敬请期待"),
                      ),
                      _optionWidget(
                        "物品审核   ",
                        Icons.manage_accounts,
                            () => Get.context?.showMessageDialog("敬请期待"),
                        "图鉴审核   ",
                        Icons.question_answer_outlined,
                            () => Get.context?.showMessageDialog("敬请期待"),
                      ),
                      _optionWidget(
                        "主菜单按钮",
                        Icons.menu,
                        () => _.toMainMenuPage(),
                        "白名单列表",
                        Icons.playlist_add_check_outlined,
                        () => _.toWhitelistPage(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  _optionWidget(
    String btnText1,
    IconData icon1,
    Function()? onPressed1,
    String btnText2,
    IconData icon2,
    Function()? onPressed2, {
    bool isFirstLine = false,
  }) {
    var marginTop = 20.0;
    if (isFirstLine) {
      marginTop = 0;
    }
    var iconSize = 20.0;
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            icon: Icon(icon1, size: iconSize),
            label: Text(
              btnText1,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 70),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed1,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: ElevatedButton.icon(
              icon: Icon(icon2, size: iconSize),
              label: Text(
                btnText2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onPressed2,
            ),
          ),
        ],
      ),
    );
  }

  LoginController _loginController() {
    return Get.find<LoginController>();
  }
}
