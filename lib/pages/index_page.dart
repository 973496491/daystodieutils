import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _optionWidget(
              "登录      ",
              Icons.manage_accounts,
              () => _loginController().showLoginDialog(context),
              "白名单列表",
              Icons.playlist_add_check_outlined,
              () => Get.toNamed(RouteNames.whitelist),
              isFirstLine: true,
            ),
            _optionWidget(
              "物品图鉴   ",
              Icons.backup_table,
              () => Get.toNamed(RouteNames.guildItem),
              "古神图鉴   ",
              Icons.join_inner_outlined,
              () => Get.toNamed(RouteNames.guildZombieList),
            ),
            _optionWidget(
              "任务攻略   ",
              Icons.question_answer_outlined,
              () => Get.toNamed(RouteNames.whitelist),
              "主菜单按钮",
              Icons.menu,
              () => Get.toNamed(RouteNames.mainMenu),
            ),
          ],
        ),
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
