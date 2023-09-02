import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  InkWell onClick(GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }

  void setTextFieldText() {}
}

extension TextEditingControllerExt on TextEditingController {
  void setText(String content) {
    text = content;
    selection = TextSelection.fromPosition(
      TextPosition(offset: text.length),
    );
  }
}
