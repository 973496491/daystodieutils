import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/pages/login/login_controller.dart';
import 'package:daystodieutils/utils/view_ext.dart';
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
            Text(
              "管理员登录",
              style: Theme.of(context).textTheme.headlineMedium,
            ).onClick(() => _loginController().showLoginDialog(context)),
            Text(
              "白名单列表",
              style: Theme.of(context).textTheme.headlineMedium,
            ).onClick(() => Get.toNamed(RouteNames.whitelist)),
            Text(
              "物品图鉴",
              style: Theme.of(context).textTheme.headlineMedium,
            ).onClick(() => Get.toNamed(RouteNames.guildItem)),
            Text(
              "古神图鉴",
              style: Theme.of(context).textTheme.headlineMedium,
            ).onClick(() => Get.toNamed(RouteNames.guildZombieList)),
            Text(
              "任务攻略",
              style: Theme.of(context).textTheme.headlineMedium,
            ).onClick(() => Get.toNamed(RouteNames.whitelist)),
            Text(
              "主菜单按钮",
              style: Theme.of(context).textTheme.headlineMedium,
            ).onClick(() => Get.toNamed(RouteNames.mainMenu)),
          ],
        ),
      ),
    );
  }

  LoginController _loginController() {
    return Get.find<LoginController>();
  }
}
