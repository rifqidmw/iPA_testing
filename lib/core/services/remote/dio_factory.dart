import 'package:base_flutter/core/env.dart';
import 'package:base_flutter/presentation/resources/constants_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../local/app_prefs.dart';

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    String language = await _appPreferences.getAppLanguage();
    final Map<String, String> _headers = {
      'Content-Type': 'application/json',
      // 'authorization': Constants.token,
      // 'language': language,
    };
    Dio dio = Dio();
    dio.options = BaseOptions(
      headers: _headers,
      receiveTimeout: const Duration(milliseconds: AppConstants.apiTimeOut),
      sendTimeout: const Duration(milliseconds: AppConstants.apiTimeOut),
      baseUrl: AppEnvironment.baseApiUrl,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
