extension ListExt on List? {

  dynamic getOrNull(int index) {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    if (this!.length < index + 1) return null;
    return this![index];
  }
}