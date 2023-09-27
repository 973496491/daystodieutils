import 'package:daystodieutils/pages/message/message_controller.dart';
import 'package:daystodieutils/utils/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  final double _marginLeft = 30;
  final double _titleWidth = 80;
  final double _contentWidth = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewUtils.getAppBar("意见反馈"),
      backgroundColor: Colors.white30,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
            ),
            _inputContainer(60, "*昵称: ", _controller().nameController),
            _inputContainer(300, "*意见: ", _controller().contentController),
            _inputContainer(60, "联络方式: ", _controller().contactInfoController),
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
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                "为了[旧日支配者工具]更好的更新, 请在此留下你宝贵的意见, 其中带*为必填项.",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14,
                ),
              ),
            ),
          ],
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
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        border: Border.all(
          width: 0.5,
          color: Colors.deepPurpleAccent,
        ),
      ),
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

  MessageController _controller() {
    return Get.find<MessageController>();
  }
}
