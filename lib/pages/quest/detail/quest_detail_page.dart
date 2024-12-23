import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:daystodieutils/utils/page_utils.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'quest_detail_controller.dart';

class QuestDetailPage extends GetView<QuestDetailController> {
  const QuestDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("任务详情"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: GetBuilder<QuestDetailController>(
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
                        GetBuilder<QuestDetailController>(
                          id: QuestDetailController.idIcon,
                          builder: (context) {
                            if (_.iconUrl == null) {
                              return Container(
                                width: 400,
                                height: 400,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/temp.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                              ).onClick(() => _.selectImage());
                            } else {
                              "loadImage url: ${_.iconUrl}".logI();
                              return Container(
                                width: 400,
                                height: 400,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(_.iconUrl ?? ""),
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
                          width: 500,
                          margin: const EdgeInsets.only(left: 50),
                          constraints: const BoxConstraints(
                            minHeight: 400,
                          ),
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
                            children: [
                              _itemWidget("名        称: ", _.nameEditController,
                                  isFirst: true),
                              const Divider(color: Colors.black12),
                              _itemWidget("获取方式: ", _.getWayEditController),
                              const Divider(color: Colors.black12),
                              _itemWidget(
                                  "工  作  台: ", _.workstationEditController),
                              const Divider(color: Colors.black12),
                              _itemWidget("配        方: ", _.recipesEditController)
                                  .onClick(
                                    () => PageUtils.showItemDetailPageDialog(
                                      _.recipesArray
                                    ),
                              ),
                              const Divider(color: Colors.black12),
                              _itemWidget(
                                  "作        用: ", _.introductionEditController),
                            ],
                          ),
                        ),
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
                          child: GetBuilder<QuestDetailController>(
                            id: QuestDetailController.idEdit,
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
                          GetBuilder<QuestDetailController>(
                            id: QuestDetailController.idEdit,
                            builder: (_) {
                              return _optionWidget(
                                _.editText,
                                () => _.changeCanEdit(),
                              );
                            },
                          ),
                          GetBuilder<QuestDetailController>(
                            id: QuestDetailController.idDelete,
                            builder: (context) {
                              if (_.canDelete) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: _optionWidget("删除", () => _.delete()),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          GetBuilder<QuestDetailController>(
                            id: QuestDetailController.idCommit,
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
      padding: const EdgeInsets.only(left: 20, top: 27, bottom: 27),
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
    return Expanded(
      child: Container(
        width: MediaQuery.of(Get.context!).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10),
        child: GetBuilder<QuestDetailController>(
          id: QuestDetailController.idEdit,
          builder: (context) {
            return TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              focusNode: focusNode,
              enabled: _controller().canEdit,
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

  QuestDetailController _controller() {
    return Get.find<QuestDetailController>();
  }
}
