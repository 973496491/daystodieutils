import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customization_controller.dart';
import 'customization_type_enum.dart';

class CustomizationPage extends GetView<CustomizationController> {
  const CustomizationPage({Key? key}) : super(key: key);

  final double _marginLeft = 30;
  final double _titleWidth = 80;
  final double _contentWidth = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("我要定制"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: GetBuilder<CustomizationController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                ),
                _inputContainer(60, "*定制名称: ", _controller().nameController),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _leftTitle(60, "*定制类型: "),
                      Container(
                        width: _contentWidth,
                        height: 60,
                        margin: EdgeInsets.only(left: _marginLeft),
                        child: Form(
                          child: DropdownButtonFormField<int>(
                            value: _.type,
                            items: CustomizationTypeEnum.typeList.map(
                              (value) {
                                return DropdownMenuItem<int>(
                                  value: value.type,
                                  child: Text(value.typeDesc),
                                );
                              },
                            ).toList(),
                            icon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.deepPurpleAccent,
                            ),
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                _.type = newValue;
                                for (var element in CustomizationTypeEnum.typeList) {
                                  if (element.type == newValue) {
                                    _.typeDesc = element.typeDesc;
                                    continue;
                                  }
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _inputContainer(300, "简略描述: ", _controller().descController),
                _inputContainer(
                    60, "*联络方式: ", _controller().contactInfoController),
                Container(
                  width: 160,
                  height: 40,
                  margin: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () => _controller().commit(),
                    child: const Text(
                      "提交",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _inputContainer(
    double height,
    String titleStr,
    TextEditingController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _leftTitle(height, titleStr),
          _inputText(height, controller),
        ],
      ),
    );
  }

  _leftTitle(double height, String str) {
    return Container(
      width: _titleWidth,
      height: height,
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        str,
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }

  _inputText(
    double height,
    TextEditingController controller,
  ) {
    return Container(
      width: _contentWidth,
      height: height,
      margin: EdgeInsets.only(left: _marginLeft),
      decoration: _boxShape(),
      child: TextFormField(
        maxLines: null,
        controller: controller,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(20),
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  CustomizationController _controller() {
    return Get.find<CustomizationController>();
  }

  _boxShape() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(4.0),
      ),
      border: Border.all(
        width: 0.5,
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
