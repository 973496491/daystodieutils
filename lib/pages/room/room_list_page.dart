import 'package:daystodieutils/config/route_config.dart';
import 'package:daystodieutils/module/entity/room_list_resp.dart';
import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/pages/room/room_list_controller.dart';
import 'package:daystodieutils/utils/string_ext.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RoomListPage extends GetView<RoomListController> {
  const RoomListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("单机群列表"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<RoomListController>(
                  id: RoomListController.idListView,
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
        child: GetBuilder<RoomListController>(
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
                  onPressed: () => _.addRoom(null),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _gridViewWidget(RoomListController controller) {
    return PagedGridView<int, RoomListResp>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<RoomListResp>(
        itemBuilder: (context, item, index) => _itemWidget(item),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        crossAxisSpacing: 10, // 横轴方向子元素的间距。
        mainAxisSpacing: 10, // 主轴方向的间距。
      ),
    );
  }

  _itemWidget(RoomListResp? item) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconWidget(item?.roomIcon),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start, // 横轴
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 纵轴
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
                  Text(
                    "QQ群: ${item?.roomNumber ?? "--"}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).onClick(() => _controller().onItemClick(item?.id, item?.roomUrl));
  }

  _iconWidget(String? url) {
    double imageSize = 90;
    if (url == null) {
      return Container(
        width: imageSize,
        height: imageSize,
        margin: const EdgeInsets.only(left: 20),
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
    } else {
      return Container(
        width: imageSize,
        height: imageSize,
        margin: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url.thumbnailUrl()),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      );
    }
  }

  RoomListController _controller() {
    return Get.find<RoomListController>();
  }
}
