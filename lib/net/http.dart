import 'dart:convert';

import 'package:daystodieutils/module/user/user_manager.dart';
import 'package:daystodieutils/net/http_config.dart';
import 'package:daystodieutils/utils/logger_ext.dart';
import 'package:dio/dio.dart';

import 'http_api.dart';

class Http {
  static Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) {
    return _request(path, "get", params: params);
  }

  static Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) {
    return _request(path, "post", params: params, data: data);
  }

  // 配置 Dio 实例
  static final BaseOptions _options = BaseOptions(
    baseUrl: HttpApi.baseUrl,
    connectTimeout: HttpConfig.connectTimeout,
    receiveTimeout: HttpConfig.receiveTimeout,
  );

  static final Dio _dio = Dio(_options);

  static Future<Map<String, dynamic>> _request(
    String path,
    String method, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async {
    try {
      _dio.options.headers["Access-Control-Allow-Origin"] = "*";
      _dio.options.headers["Access-Control-Allow-Credentials"] = "true";
      _dio.options.headers["Access-Control-Allow-Headers"] = "*";
      _dio.options.headers["Access-Control-Allow-Methods"] = "*";

      _dio.options.headers["token"] = UserManager.getToken();

      "[Dio]\nurl: ${HttpApi.baseUrl}$path\nheaders: ${_dio.options.headers.toString()}\nparams: ${params.toString()}\ndata:${data.toString()}"
          .logD();

      Response response = await _dio.request(
        path,
        queryParameters: params,
        data: data,
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
            return Future.error('解析响应数据异常');
          }
        } else {
          return Future.error('解析响应数据异常');
        }
      } else {
        "response.data is null".logE();
        return Future.error("服务器异常");
      }
    } on DioException catch (e, _) {
      String errorMessage = _dioError(e);
      errorMessage.logE();
      return Future.error(errorMessage);
    } catch (e, _) {
      "未知异常".logE();
      return Future.error("未知异常");
    }
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
