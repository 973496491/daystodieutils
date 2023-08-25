import 'package:daystodieutils/pages/guide/item/guide_item_controller.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideItemPage extends GetView<GuideItemController> {
  const GuideItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("物品图鉴"),
      body: const SafeArea(
        child: Column(
          children: [
            Text(
              "名称: ",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
