import 'dart:convert';

import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/n_http_config.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:dio/dio.dart';

class Http {
  static Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    String? contentType,
  }) {
    return _request(path, "get", params: params, contentType: contentType);
  }

  static Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    String? contentType,
  }) {
    return _request(path, "post",
        params: params, data: data, contentType: contentType);
  }

  static Future postFile(
    String path,
    FormData formData,
  ) {
    return _request(path, "post", formData: formData);
  }

  // 配置 Dio 实例
  static final BaseOptions _options = BaseOptions(
    baseUrl: NHttpConfig.baseUrl,
    connectTimeout: NHttpConfig.connectTimeout,
    receiveTimeout: NHttpConfig.receiveTimeout,
  );

  static final Dio _dio = Dio(_options);

  static Future<Map<String, dynamic>> _request(
    String path,
    String method, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    String? contentType,
    FormData? formData,
  }) async {
    try {
      _dio.options.headers["Access-Control-Allow-Origin"] = "*";
      _dio.options.headers["Access-Control-Allow-Credentials"] = "true";
      _dio.options.headers["Access-Control-Allow-Headers"] = "*";
      _dio.options.headers["Access-Control-Allow-Methods"] = "*";

      _dio.options.headers["token"] = UserManager.getToken();

      if (true == contentType?.isNotEmpty) {
        "[Dio]\n 手动指定Content-Type: $contentType".logD();
        _dio.options.contentType = contentType;
      }

      "[Dio]\n"
          "url: ${NHttpConfig.baseUrl}$path\n"
          "headers: ${_dio.options.headers.toString()}\n"
          "params: ${params.toString()}\n"
          "data:${data.toString()}]\n"
          "fromData: $formData"
          .logD();

      Object? body;
      if (formData != null) {
        body = formData;
        "[Dio]\n 当前Body为图片参数".logD();
      } else {
        body = data;
      }

      Response response = await _dio.request(
        path,
        queryParameters: params,
        data: body,
        options: Options(method: method),
      );
      "[Dio]\nresp: ${response.toString()}".logD();
      if (response.data != null) {
        if (response.statusCode == 200) {
          try {
            String dataStr = json.encode(response.data);
            Map<String, dynamic> dataMap = json.decode(dataStr);
            return dataMap;
          } catch (e) {
            "解析响应数据异常: $e".logE();
            return Future.value(_generateErrorMap("解析响应数据异常"));
          }
        } else {
          return Future.value(_generateErrorMap("解析响应数据异常"));
        }
      } else {
        "response.data is null".logE();
        return Future.value(_generateErrorMap("服务器异常"));
      }
    } on DioException catch (e, _) {
      String errorMessage = _dioError(e);
      errorMessage.logE();
      return Future.value(_generateErrorMap(errorMessage));
    } catch (e, _) {
      "未知异常".logE();
      return Future.value(_generateErrorMap("未知异常"));
    }
  }

  static Map<String, dynamic> _generateErrorMap(String message) {
    return {"message": message};
  }

  static String _dioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "网络连接超时，请检查网络设置";
      case DioExceptionType.receiveTimeout:
        return "服务器异常，请稍后重试！";
      case DioExceptionType.sendTimeout:
        return "网络连接超时，请检查网络设置";
      case DioExceptionType.badResponse:
        return "请求参数错误！";
      case DioExceptionType.cancel:
        return "请求已被取消，请重新请求";
      default:
        return "请求异常: ${error.message}";
    }
  }
}
