import 'package:daystodieutils/module/entity/quest_list_resp.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/pages/quest/list/quest_list_controller.dart';
import 'package:daystodieutils/utils/string_ext.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class QuestListPage extends GetView<QuestListController> {
  const QuestListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar(
        "任务列表",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GetBuilder<QuestListController>(builder: (_) {
              return const Text(
                "搜索",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ).onClick(() => _.showSearchDialog());
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
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<QuestListController>(
                  id: QuestListController.idListView,
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
        child: GetBuilder<QuestListController>(
          builder: (_) {
            if (UserManager.getToken() == null) {
              return Container();
            } else {
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
                  onPressed: () => _.toDetailPage(null),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _gridViewWidget(QuestListController controller) {
    return PagedGridView<int, QuestListResp>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<QuestListResp>(
        itemBuilder: (context, item, index) => _itemWidget(item),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10, // 横轴方向子元素的间距。
        mainAxisSpacing: 10, // 主轴方向的间距。
      ),
    );
  }

  _itemWidget(QuestListResp? item) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _iconWidget(item?.imageUrl),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              item?.name ?? "--",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    ).onClick(() => controller.toDetailPage(item?.id));
  }

  _iconWidget(String? url) {
    double imageSize = 80;
    if (url != null) {
      return SizedBox(
        width: imageSize,
        height: imageSize,
        child: FastCachedImage(
          url: url.thumbnailUrl(),
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        width: imageSize,
        height: imageSize,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/temp.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      );
    }
  }
}
