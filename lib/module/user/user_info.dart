class UserInfo {
  UserInfo({
    this.token,
    this.serviceToken,
    this.serviceKey,
    this.userLeave,
  });

  String? token;
  String? serviceToken;
  String? serviceKey;
  int? userLeave;

  static UserInfo formatMap(Map map) {
    return UserInfo(
      token: map["token"],
      serviceToken: map["serviceToken"],
      serviceKey: map["serviceKey"],
      userLeave: map["userLeave"],
    );
  }

  UserInfo.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    serviceToken = json["serviceToken"];
    serviceKey = json["serviceKey"];
    userLeave = json["userLeave"];
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "serviceToken": serviceToken,
      "serviceKey": serviceKey,
      "userLeave": userLeave,
    };
  }
}
