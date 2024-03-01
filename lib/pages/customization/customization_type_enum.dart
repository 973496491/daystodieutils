class CustomizationTypeEnum {
  static const List<CustomizationTypeEnumMember> typeList = [
    props, module, map, prefabs
  ];

  static const CustomizationTypeEnumMember props =
      CustomizationTypeEnumMember(1, '道具');
  static const CustomizationTypeEnumMember module =
      CustomizationTypeEnumMember(2, '模组');
  static const CustomizationTypeEnumMember map =
      CustomizationTypeEnumMember(3, '地图');
  static const CustomizationTypeEnumMember prefabs =
      CustomizationTypeEnumMember(4, '预制件&副本');
}

class CustomizationTypeEnumMember {
  final int type;
  final String typeDesc;

  const CustomizationTypeEnumMember(this.type, this.typeDesc);
}
