enum HttpContentType {
  applicationJson("application/json;charset=UTF-8"),

  multipartFormData("multipart/form-data"),

  formUrlencoded("application/x-www-form-urlencoded");

  const HttpContentType(this.type);

  final String type;
}