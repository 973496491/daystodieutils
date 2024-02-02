import 'package:card_swiper/card_swiper.dart';
import 'package:daystodieutils/config/config.dart';
import 'package:daystodieutils/config/route_config.dart';
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
        child: GetBuilder<mic.IndexController>(
          builder: (_) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: GetBuilder<mic.IndexController>(
                        builder: (_) {
                          return _banner(_);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
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
                            () => _.toItemPage(Config.itemStatusReviewed),
                            "古神图鉴   ",
                            Icons.join_inner_outlined,
                            () => Get.toNamed(RouteNames.guildZombieList),
                            "任务攻略   ",
                            Icons.question_answer_outlined,
                            () => Get.toNamed(RouteNames.questList),
                          ),
                          _optionWidget(
                            "我要联机   ",
                            Icons.add_home_outlined,
                            () => Get.toNamed(RouteNames.joinServicePage),
                            "我要加群   ",
                            Icons.account_circle_outlined,
                            () => Get.toNamed(RouteNames.roomList),
                            "意见反馈   ",
                            Icons.account_balance_wallet_outlined,
                            () => Get.toNamed(RouteNames.message),
                          ),
                          _optionWidget(
                            "全景地图   ",
                            Icons.map,
                            () => Get.toNamed(RouteNames.mapList),
                            "我要定制   ",
                            Icons.currency_exchange,
                            () => Get.toNamed(RouteNames.customization),
                            "更多功能   ",
                            Icons.read_more_rounded,
                            () => {},
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
                            "服务器专用",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          _optionWidget(
                            "物品添加   ",
                            Icons.account_tree_outlined,
                            () => _.toServiceItemPage(),
                            "物品查看   ",
                            Icons.join_inner_outlined,
                            () => _.showServiceItemPageDialog(),
                            "更多功能   ",
                            Icons.read_more_rounded,
                            () => {},
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
                          GetBuilder<mic.IndexController>(
                            id: mic.IndexController.idLogin,
                            builder: (_) {
                              return _optionWidget(
                                _.loginText,
                                Icons.manage_accounts,
                                () => _.login(),
                                "物品审核   ",
                                Icons.add_chart,
                                () => _.toItemPage(Config.itemStatusUnreview),
                                "图鉴审核   ",
                                Icons.add_chart,
                                () => Get.context?.showMessageDialog("敬请期待"),
                              );
                            },
                          ),
                          _optionWidget(
                            "主菜单按钮",
                            Icons.menu,
                            () => _.toMainMenuPage(),
                            "白名单列表",
                            Icons.playlist_add_check_outlined,
                            () => _.toWhitelistPage(),
                            "更多功能   ",
                            Icons.question_answer_outlined,
                            () => Get.context?.showMessageDialog("敬请期待"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            );
          },
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
    Function()? onPressed2,
    String btnText3,
    IconData icon3,
    Function()? onPressed3, {
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
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: ElevatedButton.icon(
              icon: Icon(icon3, size: iconSize),
              label: Text(
                btnText3,
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
              onPressed: onPressed3,
            ),
          ),
        ],
      ),
    );
  }

  _banner(mic.IndexController _) {
    return SizedBox(
      width: 1200,
      height: 300,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _.banners[index].imageUrl ?? "",
            fit: BoxFit.cover,
          );
        },
        itemCount: _.banners.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}
