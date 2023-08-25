class UserInfo {
  UserInfo({this.token});

  String? token;

  static UserInfo formatMap(Map map) {
    return UserInfo(
      token: map["token"],
    );
  }

  UserInfo.fromJson(Map<String, dynamic> json) : token = json["token"];

  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}
