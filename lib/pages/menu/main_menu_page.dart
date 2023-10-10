import 'package:daystodieutils/pages/menu/main_menu_controller.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../module/entity/main_menu_item_resp.dart';

class MainMenuPage extends GetView<MainMenuController> {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("主菜单按钮"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: GetBuilder<MainMenuController>(
                  id: MainMenuController.idListView,
                  builder: (_) {
                    return ListView.builder(
                      itemCount: _.itemList.length,
                      itemBuilder: (context, index) {
                        return _itemBtnListWidget(_, context, _.itemList[index]);
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
              onPressed: () => _.showEditBtnInfoDialog(true),
            );
          },
        ),
      ),
    );
  }

  _itemBtnListWidget(
    MainMenuController controller,
    BuildContext context,
    MainMenuItemResp? item,
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
                  flex: 4,
                  child: Text(
                    "链接: ${item?.url}",
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.black26),
        ],
      ),
    ).onClick(() => controller.showEditDialog(item!));
  }
}
