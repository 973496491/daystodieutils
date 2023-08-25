import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension WidgetExt on Widget {

  InkWell onClick(GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }
}