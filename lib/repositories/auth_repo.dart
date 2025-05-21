import 'package:flutter/material.dart';
import 'package:skyedge/models/user_model.dart';
import 'package:skyedge/network/api_endpoints.dart';
import 'package:skyedge/network/api_hitter.dart';
import 'package:skyedge/service/local_storage.dart';
import 'package:skyedge/utils/logger.dart';

class AuthRepo {
  final ApiHitter _apiClient = ApiHitter();

  Future<ApiResponse?> createUser(
    UserModel user,
  ) async {
    try {
      var body = user.toJson();
      debugPrint('body: $body');
      var res = await _apiClient.getPostApiResponse(Endpoints.registerUser,
          data: body);
      return res;
    } catch (e) {
      MyLogger.log(e);
    }
    return null;
  }

  Future<ApiResponse?> loginUser(
    String phoneNumber,
  ) async {
    try {
      var body = {
        "mobile_number": phoneNumber,
      };
      debugPrint('body: $body');
      var res =
          await _apiClient.getPostApiResponse(Endpoints.loginUser, data: body);
      return res;
    } catch (e) {
      MyLogger.log(e);
    }
    return null;
  }

  Future<ApiResponse?> getUserData(String fcmToken) async {
    try {
      var token = await MyLocalStorage.getToken();
      var endpoint = Endpoints.getuserData;
      var res = await _apiClient.getApiResponse(
        endpoint,
        headers: {"Authorization": "Bearer $token"},
      );
      return res;
    } catch (e) {
      MyLogger.log(e);
    }
    return null;
  }
}
