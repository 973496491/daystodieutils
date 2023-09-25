import 'package:daystodieutils/config/config.dart';
import 'package:daystodieutils/pages/guide/item/info/item_info_controller.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemInfoPage extends GetView<ItemInfoController> {
  const ItemInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("道具图鉴"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: GetBuilder<ItemInfoController>(
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
                        GetBuilder<ItemInfoController>(
                          id: ItemInfoController.idIcon,
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
                                  "作        用: ", _.introductionEditController),
                            ],
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
                          GetBuilder<ItemInfoController>(
                              id: ItemInfoController.idEdit,
                              builder: (_) {
                                if (_.status ==
                                    "${Config.itemStatusReviewed}") {
                                  return _optionWidget(
                                    _.editText,
                                    () => _.changeCanEdit(),
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          GetBuilder<ItemInfoController>(
                            id: ItemInfoController.idDelete,
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
                          GetBuilder<ItemInfoController>(
                            id: ItemInfoController.idCommit,
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
                          GetBuilder<ItemInfoController>(
                            id: ItemInfoController.idPass,
                            builder: (_) {
                              if (_.canPass) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: _optionWidget(
                                    "通过",
                                    () => _.review(),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          GetBuilder<ItemInfoController>(
                            id: ItemInfoController.idReject,
                            builder: (_) {
                              if (_.canReject) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: _optionWidget(
                                    "拒绝",
                                    () => _.delete(),
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
    var controller = Get.find<ItemInfoController>();
    return Expanded(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10),
        child: GetBuilder<ItemInfoController>(
          id: ItemInfoController.idEdit,
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

  ItemInfoController _controller() {
    return Get.find<ItemInfoController>();
  }
}
