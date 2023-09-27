import 'package:daystodieutils/pages/guide/item/info/item_info_binding.dart';
import 'package:daystodieutils/pages/guide/item/info/item_info_page.dart';
import 'package:daystodieutils/pages/guide/item/list/item_list_binding.dart';
import 'package:daystodieutils/pages/guide/item/list/item_list_page.dart';
import 'package:daystodieutils/pages/guide/zombie/info/guide_zombie_binding.dart';
import 'package:daystodieutils/pages/guide/zombie/info/guide_zombie_page.dart';
import 'package:daystodieutils/pages/guide/zombie/list/zombie_list_binding.dart';
import 'package:daystodieutils/pages/guide/zombie/list/zombie_list_page.dart';
import 'package:daystodieutils/pages/index_binding.dart';
import 'package:daystodieutils/pages/index_page.dart';
import 'package:daystodieutils/pages/menu/main_menu_binding.dart';
import 'package:daystodieutils/pages/menu/main_menu_page.dart';
import 'package:daystodieutils/pages/message/message_binding.dart';
import 'package:daystodieutils/pages/message/message_page.dart';
import 'package:daystodieutils/pages/service/join/detail/join_service_detail_binding.dart';
import 'package:daystodieutils/pages/service/join/detail/join_service_detail_page.dart';
import 'package:daystodieutils/pages/service/join/join_service_page.dart';
import 'package:daystodieutils/pages/whitelist/whitelist_binding.dart';
import 'package:daystodieutils/pages/whitelist/whitelist_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/service/join/join_service_binding.dart';

class RoutePages {
  static List<GetPage> routeList = [
    GetPage(
      name: RouteNames.index,
      page: () => const IndexPage(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: RouteNames.whitelist,
      page: () => const WhitelistPage(),
      binding: WhitelistBinding(),
    ),
    GetPage(
      name: RouteNames.guildItemList,
      page: () => const ItemListPage(),
      binding: ItemListBinding(),
    ),
    GetPage(
      name: RouteNames.guildZombie,
      page: () => const GuideZombiePage(),
      binding: GuideZombieBinding(),
    ),
    GetPage(
      name: RouteNames.guildZombieList,
      page: () => ZombieListPage(),
      binding: ZombieListBinding(),
    ),
    GetPage(
      name: RouteNames.mainMenu,
      page: () => const MainMenuPage(),
      binding: MainMenuBinding(),
    ),
    GetPage(
      name: RouteNames.joinServicePage,
      page: () => const JoinServicePage(),
      binding: JoinServiceBinding(),
    ),
    GetPage(
      name: RouteNames.joinServiceDetailPage,
      page: () => const JoinServiceDetailPage(),
      binding: JoinServiceDetailBinding(),
    ),
    GetPage(
      name: RouteNames.itemInfo,
      page: () => const ItemInfoPage(),
      binding: ItemInfoBinding(),
    ),
    GetPage(
      name: RouteNames.message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
    ),
  ];
}

class RouteNames {
  static String index = "/";
  static String whitelist = "/whitelist";
  static String guildItemList = "/guildItemList";
  static String guildZombie = "/guildZombie";
  static String guildZombieList = "/guildZombieList";
  static String mainMenu = "/mainMenu";
  static String joinServicePage = "/joinServicePage";
  static String joinServiceDetailPage = "/joinServiceDetailPage";
  static String itemInfo = "/itemInfo";
  static String message = "/message";
}
