// import 'dart:io';

// import 'package:bot_toast/bot_toast.dart';
// import 'package:dio/dio.dart';

// import '../utils/endpoints.dart';
// import '../utils/globals.dart';
// import '../utils/logger.dart';
// import '../widgets/toast_widget.dart';
// import 'local_storage.dart';

// class ApiClient {
//   final Dio _dio = Dio();

//   ApiClient() {
//     // You can add common configurations here, such as base URL or headers.
//     _dio.options.baseUrl = Endpoints.baseUrl;
//     // _dio.options.connectTimeout = const Duration(seconds: 7); // 7 seconds
//     // _dio.options.receiveTimeout = const Duration(seconds: 10); // 10 seconds
//     _dio.interceptors.add(
//       LogInterceptor(
//         request: false,
//         requestBody: true,
//         responseBody: true,
//       ),
//     );
//   }

//   // GET Request
//   Future<Response> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     bool showLoader = true,
//   }) async {
//     CancelFunc? cancel;
//     if (showLoader) cancel = customLoader();
//     try {
//       GbLogger.wtf(Globals.headers);
//       final response = await _dio.get(
//         path,
//         queryParameters: queryParameters,
//         options: Options(headers: Globals.headers),
//       );
//       if (showLoader) cancel!();
//       if (response.statusCode == 200 &&
//           response.data.toString().contains('Token Time Expire')) {
//         customToast(response.data['message']);
//         GbLocalStorage.clearAll();
//         // throw DioException.badResponse(
//         //     statusCode: 401,
//         //     requestOptions: RequestOptions(),
//         //     response: response.data);
//       }
//       return response;
//     } on DioException catch (e) {
//       // Handle Dio-specific errors
//       if (e.response?.statusCode == 401) {
//         if (showLoader) cancel!();
//         return e.response ??
//             Response(
//               requestOptions: e.requestOptions,
//               statusMessage: 'Token Time Expire`',
//             );
//       } else if (e.response?.statusCode == 404) {
//         GbLogger.log(
//           'Dio Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
//         );
//       } else if (e.response != null) {
//         GbLogger.log(
//           'Dio Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
//         );
//         // Handle the response data or error message
//         GbLogger.log(e.response?.data);
//       } else {
//         // Handle other Dio errors (e.g., network issues)
//         GbLogger.log('Network Error: $e');
//       }
//       if (showLoader) cancel!();
//       return e.response ??
//           Response(
//             requestOptions: e.requestOptions,
//             statusMessage: 'Something went wrong',
//           );
//     } catch (e) {
//       // Handle other exceptions (e.g., unexpected errors)
//       GbLogger.log('Unexpected Error: $e');
//       if (showLoader) cancel!();
//       rethrow; // Rethrow the error for higher-level handling, if necessary.
//     }
//   }

//   // POST Request
//   Future<Response> post(
//     String path, {
//     Map<String, dynamic>? data,
//     String? token,
//   }) async {
//     var cancel = customLoader();
//     try {
//       final response = await _dio.post(
//         path,
//         data: data,
//         options: Options(headers: Globals.headers),
//       );
//       cancel();
//       if (response.statusCode == 200 &&
//           response.data.toString().contains('Token Time Expire')) {
//         customToast(response.data['message']);
//         GbLocalStorage.clearAll();
//         // throw DioException.badResponse(
//         //     statusCode: 401,
//         //     requestOptions: RequestOptions(),
//         //     response: response.data);
//       }
//       return response;
//     } on DioException catch (e) {
//       // Handle Dio-specific errors
//       if (e.response?.statusCode == 401) {
//         cancel();
//         return e.response ??
//             Response(
//               requestOptions: e.requestOptions,
//               statusMessage: 'Token Time Expire`',
//             );
//       } else if (e.response != null) {
//         GbLogger.log(
//           'Dio Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
//         );
//         // Handle the response data or error message
//         GbLogger.log(e.response?.data);
//       } else {
//         // Handle other Dio errors (e.g., network issues)
//         GbLogger.log('Network Error: $e');
//       }
//       cancel();
//       return e.response ??
//           Response(
//             requestOptions: e.requestOptions,
//             statusMessage: 'Something went wrong',
//           );
//     } catch (e) {
//       // Handle other exceptions (e.g., unexpected errors)
//       GbLogger.log('Unexpected Error: $e');
//       cancel();
//       rethrow; // Rethrow the error for higher-level handling, if necessary.
//     }
//   }

//   // PUT Request
//   Future<Response> put(
//     String path, {
//     Map<String, dynamic>? data,
//     String? token,
//   }) async {
//     var cancel = customLoader();
//     try {
//       final response = await _dio.put(
//         path,
//         data: data,
//         options: Options(headers: Globals.headers),
//       );
//       cancel();
//       if (response.statusCode == 200 &&
//           response.data.toString().contains('Token Time Expire')) {
//         customToast(response.data['message']);
//         GbLocalStorage.clearAll();
//         // throw DioException.badResponse(
//         //     statusCode: 401,
//         //     requestOptions: RequestOptions(),
//         //     response: response.data);
//       }
//       return response;
//     } on DioException catch (e) {
//       // Handle Dio-specific errors
//       if (e.response?.statusCode == 401) {
//         cancel();
//         return e.response ??
//             Response(
//               requestOptions: e.requestOptions,
//               statusMessage: 'Token Time Expire`',
//             );
//       } else if (e.response != null) {
//         GbLogger.log(
//           'Dio Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
//         );
//         // Handle the response data or error message
//         GbLogger.log(e.response?.data);
//       } else {
//         // Handle other Dio errors (e.g., network issues)
//         GbLogger.log('Network Error: $e');
//       }
//       cancel();
//       return e.response ??
//           Response(
//             requestOptions: e.requestOptions,
//             statusMessage: 'Something went wrong',
//           );
//     } catch (e) {
//       // Handle other exceptions (e.g., unexpected errors)
//       GbLogger.log('Unexpected Error: $e');
//       cancel();
//       rethrow; // Rethrow the error for higher-level handling, if necessary.
//     }
//   }

//   // DELETE Request
//   Future<Response> delete(String path, String? token) async {
//     var cancel = customLoader();
//     try {
//       final response =
//           await _dio.delete(path, options: Options(headers: Globals.headers));
//       cancel();
//       if (response.statusCode == 200 &&
//           response.data.toString().contains('Token Time Expire')) {
//         customToast(response.data['message']);
//         GbLocalStorage.clearAll();
//         // throw DioException.badResponse(
//         //     statusCode: 401,
//         //     requestOptions: RequestOptions(),
//         //     response: response.data);
//       }
//       return response;
//     } on DioException catch (e) {
//       // Handle Dio-specific errors
//       if (e.response?.statusCode == 401) {
//         cancel();
//         return e.response ??
//             Response(
//               requestOptions: e.requestOptions,
//               statusMessage: 'Token Time Expire`',
//             );
//       } else if (e.response != null) {
//         GbLogger.log(
//           'Dio Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
//         );
//         // Handle the response data or error message
//         GbLogger.log(e.response?.data);
//       } else {
//         // Handle other Dio errors (e.g., network issues)
//         GbLogger.log('Network Error: $e');
//       }
//       cancel();
//       return e.response ??
//           Response(
//             requestOptions: e.requestOptions,
//             statusMessage: 'Something went wrong',
//           );
//     } catch (e) {
//       // Handle other exceptions (e.g., unexpected errors)
//       GbLogger.log('Unexpected Error: $e');
//       cancel();
//       rethrow; // Rethrow the error for higher-level handling, if necessary.
//     }
//   }

//   Future<Response> upload(File file) async {
//     var cancel = customLoader('Uploading file');
//     try {
//       final formData = FormData.fromMap({
//         'files': MultipartFile.fromBytes(
//           file.readAsBytesSync(),
//           filename: file.path,
//         ),
//       });
//       final response = await _dio.post(
//         Endpoints.imageUpload,
//         options: Options(
//           headers: {
//             // 'User-Agent': 'PostmanRuntime/7.33.0',
//             'Authorization': Globals.headers['Authorization'],
//           },
//           contentType: 'application/json',
//         ),
//         data: formData,
//       );
//       cancel();
//       if (response.statusCode == 200 &&
//           response.data.toString().contains('Token Time Expire')) {
//         customToast(response.data['message']);
//         GbLocalStorage.clearAll();
//         // throw DioException.badResponse(
//         //     statusCode: 401,
//         //     requestOptions: RequestOptions(),
//         //     response: response.data);
//       }
//       return response;
//     } on DioException catch (e) {
//       // Handle Dio-specific errors
//       if (e.response?.statusCode == 401) {
//         cancel();
//         return e.response ??
//             Response(
//               requestOptions: e.requestOptions,
//               statusMessage: 'Token Time Expire`',
//             );
//       } else if (e.response != null) {
//         GbLogger.log(
//           'Dio Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
//         );
//         // Handle the response data or error message
//         GbLogger.log(e.response?.data);
//       } else {
//         // Handle other Dio errors (e.g., network issues)
//         GbLogger.log('Network Error: $e');
//       }
//       cancel();
//       return e.response ??
//           Response(
//             requestOptions: e.requestOptions,
//             statusMessage: 'Something went wrong',
//           );
//     } catch (e) {
//       // Handle other exceptions (e.g., unexpected errors)
//       GbLogger.log('Unexpected Error: $e');
//       cancel();
//       rethrow; // Rethrow the error for higher-level handling, if necessary.
//     }
//   }
// }
