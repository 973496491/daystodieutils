extension StringExt on String? {
  String thumbnailUrl({
    int width = 100,
    int q = 85,
  }) {
    if (this == null) return "";
    if (true != this!.isNotEmpty) return "";
    return "$this?imageView2/1/w/$width/q/$q";
  }
}
