import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'guide_zombie_controller.dart';

class GuideZombiePage extends GetView<GuideZombieController> {
  const GuideZombiePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("古神图鉴"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: GetBuilder<GuideZombieController>(
            id: GuideZombieController.idContent,
            builder: (_) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GetBuilder<GuideZombieController>(
                            id: GuideZombieController.idIcon,
                            builder: (context) {
                              if (_.iconUrl == null) {
                                return Container(
                                  width: 400,
                                  height: 550,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/temp.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ).onClick(() => _.selectImage());
                              } else {
                                return Container(
                                  width: 400,
                                  height: 550,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "${_.iconUrl}?${DateTime.now().millisecondsSinceEpoch.toString()}"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ).onClick(() => _.selectImage());
                              }
                            },
                          ),
                          Container(
                            width: 700,
                            margin: const EdgeInsets.only(left: 50),
                            child: Column(
                              children: [
                                const Divider(color: Colors.black12),
                                _itemWidget(
                                    "名        称: ", _.nameEditController,
                                    isFirst: true),
                                const Divider(color: Colors.black12),
                                _itemWidget(
                                    "类        型: ", _.typeEditController),
                                const Divider(color: Colors.black12),
                                _itemWidget("初始血量: ", _.hpEditController),
                                const Divider(color: Colors.black12),
                                _itemWidget("掉  落  物: ", _.bootyListEditController)
                                    .onClick(
                                      () => _.showItemDetailPageDialog(_.bootyListArray),
                                ),
                                const Divider(color: Colors.black12),
                                _itemWidget("尸体材料: ", _.corpseDropEditController)
                                    .onClick(
                                      () => _.showItemDetailPageDialog(_.corpseDropArray),
                                ),
                                const Divider(color: Colors.black12),
                                _itemWidget(
                                    "注意事项: ", _.precautionsEditController),
                                const Divider(color: Colors.black12),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 700,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              "攻略",
                              style: TextStyle(
                                color: Colors.deepPurpleAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: GetBuilder<GuideZombieController>(
                              id: GuideZombieController.idEdit,
                              builder: (context) {
                                return TextField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  enabled: controller.canEdit,
                                  controller: _.raidersEditController,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GetBuilder<GuideZombieController>(
                                id: GuideZombieController.idEdit,
                                builder: (_) {
                                  return _optionWidget(
                                    _.editText,
                                    () => _.changeCanEdit(),
                                  );
                                }),
                            GetBuilder<GuideZombieController>(
                              id: GuideZombieController.idDelete,
                              builder: (context) {
                                if (_.canDelete) {
                                  return Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child:
                                        _optionWidget("删除", () => _.delete()),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            GetBuilder<GuideZombieController>(
                              id: GuideZombieController.idCommit,
                              builder: (_) {
                                if (_.canCommit) {
                                  return Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    child: _optionWidget(
                                      "提交",
                                      () => _.commit(),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 30,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _itemWidget(
    String desc,
    TextEditingController textController, {
    bool isFirst = false,
  }) {
    var marginTop = 0.0;
    if (isFirst) marginTop = 0;

    FocusNode? focusNode;
    if (isFirst) {
      focusNode = FocusNode();
      _controller().focusNode = focusNode;
    }
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoItemTitle(desc),
          _infoItemContent(textController, focusNode),
        ],
      ),
    );
  }

  Widget _infoItemTitle(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 27, bottom: 27),
      child: Text(
        name,
        style: const TextStyle(
          height: 0.76,
          color: Colors.blueAccent,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoItemContent(
    TextEditingController textController,
    FocusNode? focusNode,
  ) {
    var controller = Get.find<GuideZombieController>();
    return Expanded(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10),
        child: GetBuilder<GuideZombieController>(
          id: GuideZombieController.idEdit,
          builder: (context) {
            return TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              focusNode: focusNode,
              enabled: controller.canEdit,
              controller: textController,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 25, bottom: 27),
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _optionWidget(
    String title,
    Function()? function,
  ) {
    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  GuideZombieController _controller() {
    return Get.find<GuideZombieController>();
  }
}
