import 'package:daystodieutils/pages/guide/item/guide_item_binding.dart';
import 'package:daystodieutils/pages/guide/item/guide_item_page.dart';
import 'package:daystodieutils/pages/guide/zombie/guide_zombie_binding.dart';
import 'package:daystodieutils/pages/guide/zombie/guide_zombie_page.dart';
import 'package:daystodieutils/pages/guide/zombie/list/zombie_list_binding.dart';
import 'package:daystodieutils/pages/guide/zombie/list/zombie_list_page.dart';
import 'package:daystodieutils/pages/index_binding.dart';
import 'package:daystodieutils/pages/index_page.dart';
import 'package:daystodieutils/pages/menu/main_menu_binding.dart';
import 'package:daystodieutils/pages/menu/main_menu_page.dart';
import 'package:daystodieutils/pages/whitelist/whitelist_binding.dart';
import 'package:daystodieutils/pages/whitelist/whitelist_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

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
      name: RouteNames.guildItem,
      page: () => const GuideItemPage(),
      binding: GuideItemBinding(),
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
      page: () => MainMenuPage(),
      binding: MainMenuBinding(),
    ),
  ];
}

class RouteNames {
  static String index = "/";
  static String whitelist = "/whitelist";
  static String guildItem = "/guildItem";
  static String guildZombie = "/guildZombie";
  static String guildZombieList = "/guildZombieList";
  static String mainMenu = "/mainMenu";
}
