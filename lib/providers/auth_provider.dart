import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:skyedge/models/user_model.dart';
import 'package:skyedge/repositories/auth_repo.dart';
import 'package:skyedge/service/local_storage.dart';

class AuthProvider with ChangeNotifier {
  String countrycode = "+91";
  String countryFlag = '🇮🇳';
  bool isLoginRequest = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  UserModel userModel = UserModel();

  AuthRepo authRepo = AuthRepo();

  void updateUserModel(UserModel model) {
    userModel = model;
    notifyListeners();
  }

  void updateCountryCode(String? code, String? flag) {
    if (code != null && flag != null) {
      debugPrint('code: $code flag: $flag');
      countrycode = code;
      countryFlag = flag;
    }
    notifyListeners();
  }

  /// Send OTP to the given phone number
  Future<void> sendOtp({
    required String phoneNumber,
    required bool isLoginReq,
    required Function(String verificationId) onCodeSent,
    required Function(FirebaseAuthException e) onFailed,
    required Function(PhoneAuthCredential credential) onAutoVerified,
    required Function() onCodeAutoRetrievalTimeout,
  }) async {
    isLoginRequest = isLoginReq;
    notifyListeners();
    debugPrint('isLoginRequest: $isLoginRequest');
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification (only on some devices)
        onAutoVerified(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        onCodeAutoRetrievalTimeout();
      },
    );
  }

  /// Verify the OTP entered by the user
  Future<UserCredential?> verifyOtp({
    required String otpCode,
  }) async {
    if (_verificationId == null) throw Exception('Verification ID is null');

    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otpCode,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<String> getFcmToken() async {
    String token = await FirebaseMessaging.instance.getToken() ?? '';
    debugPrint('fcm token: $token');
    return token;
  }

  Future<void> createUser() async {
    userModel.fcmToken = await getFcmToken();
    notifyListeners();
    final response = await authRepo.createUser(userModel);
    if (response?.response?.data != null) {
      var data = response?.response?.data;
      if (data['access_token'] != null) {
        MyLocalStorage.setToken(data['access_token']);
      }
    }
    debugPrint("create user rrwsponse: ${response?.response?.data}");
  }

  Future<void> loginUser() async {
    userModel.fcmToken = await getFcmToken();
    notifyListeners();
    final response = await authRepo.loginUser(userModel.phoneNumber ?? '');
    if (response?.response?.data != null) {
      var data = response?.response?.data;
      if (data['access_token'] != null) {
        MyLocalStorage.setToken(data['access_token']);
        userModel = UserModel.fromJson(data);
      }
    }
    debugPrint("login user response: ${response?.response?.data}");
  }

  Future<bool> fetchUserData() async {
    try {
      String fcmToken = await getFcmToken();
      final response = await authRepo.getUserData(fcmToken);
      if (response?.response?.data != null) {
        var data = response?.response?.data;
        userModel = UserModel.fromJson(data);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      return false;
    }
  }

  /// Optional: Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    MyLocalStorage.clearAll();
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return false;
      debugPrint("signInWithGoogle: ${googleUser.authentication}");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      debugPrint("signInWithGoogle: ${userCredential.user?.uid ?? 'null'}");
      if (userCredential.user != null) {
        userModel.id = userCredential.user?.uid;
        userModel.email = userCredential.user?.email;
        userModel.fullname = userCredential.user?.displayName;
        userModel.fcmToken = await getFcmToken();
        notifyListeners();

        // Call your backend API to register/login the user
        final response = await authRepo.createUser(userModel);
        if (response?.response?.data != null) {
          var data = response?.response?.data;
          if (data['access_token'] != null) {
            await MyLocalStorage.setToken(data['access_token']);
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      debugPrint("Error signing in with Google: $e");
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    try {
      final FacebookAuth facebookAuth = FacebookAuth.instance;
      final LoginResult result = await facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          userModel.id = userCredential.user?.uid;
          userModel.email = userCredential.user?.email;
          userModel.fullname = userCredential.user?.displayName;
          userModel.fcmToken = await getFcmToken();
          notifyListeners();

          // Call your backend API to register/login the user
          final response = await authRepo.createUser(userModel);
          if (response?.response?.data != null) {
            var data = response?.response?.data;
            if (data['access_token'] != null) {
              await MyLocalStorage.setToken(data['access_token']);
              return true;
            }
          }
        }
      }
      return false;
    } catch (e) {
      debugPrint("Error signing in with Facebook: $e");
      return false;
    }
  }

  Future<bool> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(oauthCredential);
      if (userCredential.user != null) {
        userModel.id = userCredential.user?.uid;
        userModel.email = userCredential.user?.email;
        userModel.fullname = userCredential.user?.displayName;
        userModel.fcmToken = await getFcmToken();
        notifyListeners();

        // Call your backend API to register/login the user
        final response = await authRepo.createUser(userModel);
        if (response?.response?.data != null) {
          var data = response?.response?.data;
          if (data['access_token'] != null) {
            await MyLocalStorage.setToken(data['access_token']);
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      debugPrint("Error signing in with Apple: $e");
      return false;
    }
  }
}
