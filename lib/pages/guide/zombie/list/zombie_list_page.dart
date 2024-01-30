import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
                        child: _gridViewWidget(_),
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

  _gridViewWidget(ZombieListController controller) {
    return PagedGridView<int, ZombieListResp>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<ZombieListResp>(
        itemBuilder: (context, item, index) => _itemWidget(item),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10, // 横轴方向子元素的间距。
        mainAxisSpacing: 10, // 主轴方向的间距。
        childAspectRatio: 0.65,
      ),
    );
  }

  _itemWidget(ZombieListResp? item) {
    double size = (1000 - 10 * 3) / 4;
    var imageUrl = item?.imageUrl ?? "";
    if (imageUrl.isNotEmpty) {
      imageUrl = "$imageUrl?imageView2/1/w/100/q/85";
    }
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: FastCachedImage(
                url: item?.imageUrl ?? "",
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "名称: ${item?.zombieName ?? "--"}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ).marginOnly(top: 10),
            Text(
              "类型: ${item?.zombieType ?? "--"}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ).marginOnly(top: 10),
            Text(
              "血量: ${item?.zombieHp ?? "--"}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ).marginOnly(top: 10),
          ],
        ),
      ),
    ).onClick(() => controller.toDetailPage("${item?.id}", false));
  }
}
