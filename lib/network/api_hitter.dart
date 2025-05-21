import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:skyedge/constants/app_routes.dart';
import 'package:skyedge/network/api_endpoints.dart';
import 'package:skyedge/service/local_storage.dart';
import 'package:skyedge/utils/extensions/string_extensions.dart';
import 'package:skyedge/utils/helper.dart';
import 'package:skyedge/utils/router_util.dart';

class ApiHitter {
  Dio? dio;
  static final ApiHitter singleton = ApiHitter._internal();
  factory ApiHitter() => singleton;

  ApiHitter._internal() {
    dio = getDio();
    if (!kIsWeb) {
      (dio!.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Dio getDio({String baseurl = ''}) {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: baseurl.isEmpty ? Endpoints.baseUrl : baseurl,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
      );
      return Dio(options)
        ..interceptors.add(
          LogInterceptor(
            request: false,
            requestBody: true,
            responseBody: true,
          ),
          // TalkerDioLogger(
          //   settings: const TalkerDioLoggerSettings(
          //     printRequestHeaders: true,
          //     printResponseHeaders: true,
          //     printResponseData: false,
          //   ),
          // ),
        );
    } else {
      return dio!;
    }
  }

  Future<ApiResponse> getPostApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String baseurl = '',
  }) async {
    /* if (kDebugMode) {
      print('queryParameters');
      print(endPoint);
      print(data);
    }*/
    bool value = await checkInternetConnection();
    if (value) {
      try {
        /*  if (kDebugMode) {
        print('queryParameters');
        print(data);
      }*/
        var response = await getDio(
          baseurl: baseurl,
        ).post(
          endPoint,
          options: Options(
            headers: headers,
            contentType: 'application/json',
            //  contentType: 'text/xml; charset=utf-8',
          ),
          queryParameters: queryParameters,
          data: data,
        );

        return apiData(response);
      } on DioException catch (error) {
        return exception(
          error,
        );
      }
    } else {
      return ApiResponse(
        false,
        msg: 'Check your internet connection and Please try again later.',
      );
    }
  }

  Future<ApiResponse> getPutApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String baseurl = '',
  }) async {
    if (kDebugMode) {
      print('queryParameters');
      print(data);
    }
    bool value = await checkInternetConnection();
    if (value) {
      try {
        var response = await getDio(
          baseurl: baseurl,
        ).put(
          endPoint,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ),
          data: data,
        );
        return apiData(response);
      } on DioException catch (error) {
        return exception(
          error,
        );
      }
    } else {
      return ApiResponse(
        false,
        msg: 'Check your internet connection and Please try again later.',
      );
    }
  }

  Future<ApiResponse> getApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String baseurl = '',
  }) async {
    if (kDebugMode) {
/*
      print('queryParameters');
      print(queryParameters);
      print(headers);
*/
    }
    bool value = await checkInternetConnection();
    // log("valueinternet$value");
    if (value) {
      try {
        var response = await getDio(
          baseurl: baseurl,
        ).get(
          endPoint,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ),
        );
        return apiData(response);
      } on DioException catch (error) {
        return exception(
          error,
        );
      }
    } else {
      debugPrint('not connected ');

      return ApiResponse(
        false,
        msg: 'Check your internet connection and Please try again later.',
        response: null,
      );
    }
  }

  deleteApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    String baseurl = '',
  }) async {
    if (kDebugMode) {
      print('queryParameters');
      print(data);
    }
    bool value = await checkInternetConnection();
    if (value) {
      try {
        var response = await getDio(
          baseurl: baseurl,
        ).delete(
          endPoint,
          data: data,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ),
        );
        return apiData(response);
      } on DioException catch (error) {
        return exception(
          error,
        );
      }
    } else {
      return ApiResponse(
        false,
        msg: 'Check your internet connection and Please try again later.',
      );
    }
  }

  Future<ApiResponse> getFormApiResponse(
    String endPoint, {
    FormData? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    bool value = await checkInternetConnection();
    if (value) {
      try {
        var response = await getDio().post(
          endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        );
        return apiData(response);
      } on DioException catch (e) {
        return exception(e);
      }
    } else {
      return ApiResponse(
        false,
        msg: 'Check your internet connection and Please try again later.',
      );
    }
  }

  ApiResponse exception(DioException e) {
    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        (e.response?.data['error'] ?? 'Something went wrong')
            .toString()
            .toast();
        MyLocalStorage.clearAll();
        RouterUtil.router.go(AppRoutes.loginScreen);
      }
      // debugPrint('api resp:: ${e.response?.data}');

      return ApiResponse(
        false,
        msg: e.response?.data['message'] ?? e.message,
        response: e.response,
      );
    } else {
      return ApiResponse(false, msg: e.message!, response: e.response);
    }

    // return ApiResponse(false, msg: NetworkExceptions.getErrorMessage(NetworkExceptions.getDioException(error)));
  }

  apiData(Response<dynamic> response) {
    return ApiResponse(
      response.statusCode == 200 || response.statusCode == 201,
      response: response,
      msg: response.data['message'] ?? 'Success',
    );
  }
}

class ApiResponse {
  final bool status;
  final String msg;
  final Response? response;

  ApiResponse(this.status, {this.msg = 'Success', this.response});
}
