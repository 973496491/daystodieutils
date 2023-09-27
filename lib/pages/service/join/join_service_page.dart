import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../module/entity/join_service_item_resp.dart';
import 'join_service_controller.dart';

class JoinServicePage extends GetView<JoinServiceController> {
  const JoinServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("服务器列表"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<JoinServiceController>(
                  id: JoinServiceController.idListView,
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
    );
  }

  _gridViewWidget(JoinServiceController controller) {
    return PagedGridView<int, JoinServiceItemResp>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<JoinServiceItemResp>(
        itemBuilder: (context, item, index) => _itemWidget(item),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10, // 横轴方向子元素的间距。
        mainAxisSpacing: 10, // 主轴方向的间距。
      ),
    );
  }

  _itemWidget(JoinServiceItemResp? item) {

    return Card(
      color: Colors.white,
      elevation: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconWidget(item?.thumbnailUrl),
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
                    "QQ群: ${item?.qqRoom ?? "--"}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "描述: ${item?.desc ?? "--"}",
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
    );
  }

  _iconWidget(String? url) {
    double imageSize = 130;
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
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      );
    }
  }
}
