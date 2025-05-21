import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class MyLocalStorage {
  static const String _tokenKey = 'token';
  static const String setName = 'name';
  static const String _refreshTokenKey = 'refreshToken';
  static const String _userId = 'userId';
  static const String _onboarding = 'onboarding';
  static const String _userName = 'username';
  static const String _language = 'language';
  static const String _sessionSwipeInfoShown = 'sessionSwipeInfoShown';
  static const String _sessionOngoing = 'sessionOngoing';

  static Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  static Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_tokenKey, token);
  }

  static Future<String?> getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_language);
  }

  static Future<void> setLanguage(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(_language, token);
  }

  static Future<String?> getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userName);
  }

  static Future<void> setUsername(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(setName, name);
  }

  static Future<String> getName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(setName) ?? "";
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_refreshTokenKey) ?? "";
  }

  static Future<bool> setRefreshToken(String refreshToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(
      _refreshTokenKey,
      refreshToken.toString(),
    );
  }

  static Future<String?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userId);
  }

  static Future<bool> setUserId(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(_userId, userId.toString());
  }

  static Future<bool?> getOnboarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_onboarding);
  }

  static Future<bool> setOnboarding(bool onboardStatus) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(_onboarding, onboardStatus);
  }

  static Future<bool?> getSessionSwipeInfoShown() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_sessionSwipeInfoShown);
  }

  static Future<bool> setSessionSwipeInfoShown(bool swipeShown) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(_sessionSwipeInfoShown, swipeShown);
  }

  static Future<String?> getSessionOngoing() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_sessionOngoing);
  }

  static Future<void> setSessionOngoing(String? sessionOngoing) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_sessionOngoing, sessionOngoing ?? '');
  }

  static Future<void> setAppleEmail(String appleId, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('apple_email_$appleId', email);
  }

  static Future<String?> getAppleEmail(String appleId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('apple_email_$appleId');
  }

  static Future<bool> clearAll({bool shouldPop = true}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      var r = await preferences.clear();
      return r;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
