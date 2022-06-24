import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio getDio(String url) {
  var oop = BaseOptions(
    baseUrl: url,
    connectTimeout: 200000,
    receiveTimeout: 200000,
    sendTimeout: 200000,
    headers: {
      HttpHeaders.acceptHeader: "application/json",
    },
  );
  var dio = Dio(oop);
  dio.interceptors.addAll([
    PrettyDioLogger(
        request: true,
        requestBody: true,
        error: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true)
  ]);
  return dio;
}
