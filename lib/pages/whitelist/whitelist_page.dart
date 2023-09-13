import 'package:daystodieutils/pages/whitelist/whitelist_controller.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../module/entity/whitelist_resp.dart';

class WhitelistPage extends GetView<WhitelistController> {
  const WhitelistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("白名单列表"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<WhitelistController>(
                  id: WhitelistController.idListView,
                  builder: (_) {
                    return RefreshIndicator(
                      displacement: 5,
                      onRefresh: () => Future.sync(
                        () => _.pagingController.refresh(),
                      ),
                      child: PagedListView<int, WhiteListResp>(
                        pagingController: _.pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<WhiteListResp>(
                          itemBuilder: (context, item, index) =>
                              _itemWhitelist(_, context, item),
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
        child: GetBuilder<WhitelistController>(
          builder: (_) {
            return ElevatedButton(
              child: const Text(
                "添加",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              onPressed: () => _.showAddWhitelistDialog(context),
            );
          },
        ),
      ),
    );
  }

  _itemWhitelist(
    WhitelistController controller,
    BuildContext context,
    WhiteListResp? item,
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
                  flex: 1,
                  child: Text(
                    "作者: ${item?.author}",
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
    ).onClick(() => controller.showEditDialog(context, item?.id));
  }
}
