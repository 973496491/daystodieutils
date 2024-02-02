class CustomizationTypeEnum {
  static const CustomizationTypeEnumMember props =
      CustomizationTypeEnumMember(1, '道具');
  static const CustomizationTypeEnumMember module =
      CustomizationTypeEnumMember(2, '模组');
  static const CustomizationTypeEnumMember map =
      CustomizationTypeEnumMember(3, '地图');
}

class CustomizationTypeEnumMember {
  final int type;
  final String typeDesc;

  const CustomizationTypeEnumMember(this.type, this.typeDesc);
}
