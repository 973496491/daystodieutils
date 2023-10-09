class UserInfo {
  UserInfo({
    this.token,
    this.serviceToken,
    this.serviceKey,
  });

  String? token;
  String? serviceToken;
  String? serviceKey;

  static UserInfo formatMap(Map map) {
    return UserInfo(
      token: map["token"],
      serviceToken: map["serviceToken"],
      serviceKey: map["serviceKey"],
    );
  }

  UserInfo.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    serviceToken = json["serviceToken"];
    serviceKey = json["serviceKey"];
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "serviceToken": serviceToken,
      "serviceKey": serviceKey,
    };
  }
}
