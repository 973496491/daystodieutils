import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../module/entity/zombie_list_resp.dart';
import 'zombie_list_controller.dart';

class ZombieListPage extends GetView<ZombieListController> {
  const ZombieListPage({Key? key}) : super(key: key);

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
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<ZombieListController>(
                  id: ZombieListController.idListView,
                  builder: (_) {
                    return SizedBox(
                      width: 1000,
                      child: RefreshIndicator(
                        displacement: 5,
                        onRefresh: () => Future.sync(
                          () => _.pagingController.refresh(),
                        ),
                        child: PagedListView<int, ZombieListResp>(
                          pagingController: _.pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<ZombieListResp>(
                            itemBuilder: (context, item, index) =>
                                _itemZombieListWidget(_, item),
                          ),
                        ),
                      ),
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
        width: 100,
        height: 100,
        child: GetBuilder<ZombieListController>(
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.5,
                  color: Colors.blueAccent,
                ),
              ),
              child: IconButton(
                color: Colors.blue,
                icon: const Icon(Icons.add),
                onPressed: () => _.toDetailPage("-1", true),
              ),
            );
          },
        ),
      ),
    );
  }

  _itemZombieListWidget(
    ZombieListController controller,
    ZombieListResp? item,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "名称: ${item?.zombieName}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "类型: ${item?.zombieType}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "血量: ${item?.zombieHp}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.black26),
      ],
    ).onClick(() => controller.toDetailPage("${item?.id}", false));
  }
}
