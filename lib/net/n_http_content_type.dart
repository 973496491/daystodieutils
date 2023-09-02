enum NHttpContentType {
  applicationJson("application/json;charset=UTF-8"),

  multipartFormData("multipart/form-data"),

  formUrlencoded("application/x-www-form-urlencoded");

  const NHttpContentType(this.type);

  final String type;
}