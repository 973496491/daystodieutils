import 'package:daystodieutils/net/entity/zombie_list_resp.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'zombie_list_controller.dart';

class ZombieListPage extends GetView<ZombieListController> {
  ZombieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar(
        "古神列表",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GetBuilder<ZombieListController>(
              builder: (_) {
                return const Text(
                  "删除",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ).onClick(() {});
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GetBuilder<ZombieListController>(builder: (_) {
              return const Text(
                "搜索",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ).onClick(() => _.showSearchDialog(context));
            }),
          ),
        ],
      ),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<ZombieListController>(
                  id: ZombieListController.idListView,
                  builder: (_) {
                    return ListView.builder(
                      itemCount: _.zombieList.length,
                      itemBuilder: (context, index) {
                        return _itemZombieListWidget(_, _.zombieList[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        width: 110,
        height: 35,
        child: GetBuilder<ZombieListController>(
          builder: (_) {
            return ElevatedButton(
              child: const Text(
                "添加",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              onPressed: () => {},
            );
          },
        ),
      ),
    );
  }

  _itemZombieListWidget(ZombieListController controller, ZombieListResp? item) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "名称: ${item?.zombieName}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                Text(
                  "类型: ${item?.zombieType}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
                Text(
                  "血量: ${item?.zombieHp}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.black26),
        ],
      ),
    ).onClick(() => controller.toDetailPage(item?.id, false));
  }
}
