import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewUtils {

  static AppBar getAppBar(String title, {List<Widget>? actions}) {
    return AppBar(
      backgroundColor: Colors.white30,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
        ),
      ),
      actions: actions,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}