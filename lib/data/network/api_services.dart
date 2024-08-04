import 'dart:convert';
import 'dart:io';
import 'package:base_project_mvvm_provider/models/user_model.dart';
import 'package:base_project_mvvm_provider/utils/utils/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:base_project_mvvm_provider/data/app_exceptions.dart';
import 'package:base_project_mvvm_provider/base/base_api_services.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServices extends BaseApiServices {
  final Dio _dio = Dio();

  @override
  Future getGetApiResponse(String url) async {
    dynamic responsejson;
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
    ));

    try {
      Map<String, String> headers = {};
      headers["accept"] = "application/json'";

      final user = userModelFromJson(getStringAsync('users'));

      var authorization = user.tokenMovie ?? '';
      
      final response = await _dio.get(url,
          options: Options(headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $authorization'
          }));

      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responsejson;
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
    ));

    try {
      Map<String, String> headers = {};
      headers['Content-Type'] = "application/json'";

      final response = await _dio.post(
        url,
        data: jsonEncode(data),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer '
        }),
      );


      responsejson = responseJson(response);

    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  dynamic responseJson(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = response.data;
        return jsonResponse;
      case 400:
        throw BadRequestException("Error 400");
      default:
        throw InternetException(
            "${response.statusCode} : ${response.statusMessage}");
    }
  }
}
