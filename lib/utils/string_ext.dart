import 'package:get/get.dart';

extension StringExt on String? {
  String thumbnailUrl({
    int width = 100,
    int q = 85,
  }) {
    if (this == null) return "";
    if (true != this!.isNotEmpty) return "";
    return "$this?imageView2/1/w/$width/q/$q";
  }

  int safeToInt() {
    try {
      if (this == null) return 0;
      return int.tryParse(this!) ?? 0;
    } catch(ex) {
      ex.printError();
      return 0;
    }
  }
}
