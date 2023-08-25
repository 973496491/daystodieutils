import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/pages/index_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'pages/index_page.dart';
import 'utils/sp_util.dart';

void main() {
  _init();
  runApp(const MyApp());
}

void _init() {
  SpUtil.init();
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
    );
  }
}
