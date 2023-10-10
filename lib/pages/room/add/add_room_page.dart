import 'package:daystodieutils/pages/room/add/add_room_controller.dart';
import 'package:daystodieutils/utils/string_ext.dart';
import 'package:daystodieutils/utils/view_ext.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoomPage extends GetView<AddRoomController> {
  const AddRoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("添加QQ群"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: GetBuilder<AddRoomController>(
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
                        GetBuilder<AddRoomController>(
                          id: AddRoomController.idIcon,
                          builder: (context) {
                            return _iconWidget(_.iconUrl);
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
                              _itemWidget(
                                  "群        号: ", _.numberEditController),
                              const Divider(color: Colors.black12),
                              _itemWidget("链        接: ", _.urlEditController),
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
                          GetBuilder<AddRoomController>(
                              id: AddRoomController.idEdit,
                              builder: (_) {
                                return _optionWidget(
                                  _.editText,
                                  () => _.changeCanEdit(),
                                );
                              }),
                          GetBuilder<AddRoomController>(
                            id: AddRoomController.idDelete,
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
                          GetBuilder<AddRoomController>(
                            id: AddRoomController.idCommit,
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
    var controller = Get.find<AddRoomController>();
    return Expanded(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 10),
        child: GetBuilder<AddRoomController>(
          id: AddRoomController.idEdit,
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

  _iconWidget(String? url) {
    if (url == null) {
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
      ).onClick(() => _controller().selectImage());
    } else {
      return Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url.thumbnailUrl()),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ).onClick(() => _controller().selectImage());
    }
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

  AddRoomController _controller() {
    return Get.find<AddRoomController>();
  }
}
