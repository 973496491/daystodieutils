class BaseResp<T> {

  BaseResp(this.code, this.message, this.data);

  int code;
  String? message;
  T? data;
}