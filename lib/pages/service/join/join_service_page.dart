import 'package:daystodieutils/net/entity/join_service_item_resp.dart';
import 'package:daystodieutils/pages/menu/main_menu_controller.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'join_service_controller.dart';

class JoinServicePage extends GetView<JoinServiceController> {
  const JoinServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("我要联机"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<JoinServiceController>(
                  id: JoinServiceController.idListView,
                  builder: (_) {
                    return RefreshIndicator(
                      displacement: 5,
                      onRefresh: () => Future.sync(
                            () => _.pagingController.refresh(),
                      ),
                      child: PagedGridView<int, JoinServiceItemResp>(
                        pagingController: _.pagingController,
                        builderDelegate:
                        PagedChildBuilderDelegate<JoinServiceItemResp>(
                          itemBuilder: (context, item, index) =>
                              _itemWhitelist(_, context, item),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // childAspectRatio: itemWidth / itemHeight,
                          crossAxisCount: 2,
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
        width: 110,
        height: 35,
        child: GetBuilder<MainMenuController>(
          builder: (_) {
            return ElevatedButton(
              child: const Text(
                "添加",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              onPressed: () => _.showEditBtnInfoDialog(context, true),
            );
          },
        ),
      ),
    );
  }

  _itemWhitelist(
      JoinServiceController controller,
      BuildContext context,
      JoinServiceItemResp? item,
      ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "名称: ${item?.name}",
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "描述: ${item?.desc}",
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.black26),
        ],
      ),
    );
  }
}
