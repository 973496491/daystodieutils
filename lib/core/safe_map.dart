class SafeMap {
  SafeMap(this.value);

  final dynamic value;

  SafeMap operator [](dynamic key) {
    if (value is Map) return SafeMap(value[key]);
    if (value is List) {
      List list = value;
      int max = list.length - 1;
      if (key is int && key < max) return SafeMap(value[key]);
    }
    return SafeMap(null);
  }

  dynamic get v => value;
  String? get string => value is String ? value as String : null;
  num? get number => value is num ? value as num : null;
  Map? get map => value is Map ? value as Map : null;
  List? get list => value is List ? value as List : null;
  bool get boolean => value is bool ? value as bool : false;

  bool isEmpty() {
    if (v == null) return true;
    if (string == '') return true;
    if (number == 0) return true;
    if (true == map?.keys.isEmpty) return true;
    if (true == list?.isEmpty) return true;
    if (boolean == false) return true;
    return false;
  }

  @override
  String toString() => '<SafeMap:$value>';
}