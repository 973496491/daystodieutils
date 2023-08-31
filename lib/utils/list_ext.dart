extension ListExt on List? {

  dynamic getOrNull(int index) {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    return this![index];
  }
}