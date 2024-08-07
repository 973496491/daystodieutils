import 'package:daystodieutils/config/config.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../module/entity/item_list_resp.dart';
import 'item_list_controller.dart';

class ItemListPage extends GetView<ItemListController> {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar(
        "道具列表",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GetBuilder<ItemListController>(builder: (_) {
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
            _filterWidget(),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<ItemListController>(
                  id: ItemListController.idListView,
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
        child: GetBuilder<ItemListController>(
          builder: (_) {
            if (_.status == "${Config.itemStatusUnreview}") {
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
                  onPressed: () => _.toDetailPage("-1", true),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _filterWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _filterBtnWidget("全部"),
          _filterBtnWidget("道具"),
          _filterBtnWidget("尸体材料"),
          _filterBtnWidget("一般材料"),
        ],
      ),
    );
  }

  _filterBtnWidget(String name) {
    return Container(
      width: 120,
      height: 40,
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ElevatedButton(
        onPressed: () => {},
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  _gridViewWidget(ItemListController controller) {
    return PagedGridView<int, ItemListResp>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<ItemListResp>(
        itemBuilder: (context, item, index) => _itemWidget(item),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10, // 横轴方向子元素的间距。
        mainAxisSpacing: 10, // 主轴方向的间距。
      ),
    );
  }

  _itemWidget(ItemListResp? item) {
    double imageSize = 80;
    var imageUrl = item?.imageUrl ?? "";
    if (imageUrl.isNotEmpty) {
      imageUrl = "$imageUrl?imageView2/1/w/100/q/85";
    }
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "名称: ${item?.name ?? "--"}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Container(
            width: imageSize,
            height: imageSize,
            margin: const EdgeInsets.only(top: 20),
            child: FastCachedImage(
              url: imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ).onClick(() => controller.toDetailPage("${item?.id}", false));
  }
}
