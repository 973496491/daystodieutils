import 'dart:ui';

import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/pages/index_binding.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'pages/index_page.dart';
import 'utils/sp_util.dart';

void main() {
  _init();
  runApp(const MyApp());
}

void _init() async {
  SpUtil.init();

  // 图片加载
  WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init(
    clearCacheAfter: const Duration(days: 15),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '7 DaysToDie Utils',
      home: const IndexPage(),
      initialBinding: IndexBinding(),
      initialRoute: RouteNames.index,
      getPages: RoutePages.routeList,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
    );
  }
}
