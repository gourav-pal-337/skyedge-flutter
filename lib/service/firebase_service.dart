// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> verifyPhoneNumber({
//     required String phoneNumber,
//     required Function(AuthCredential) verificationCompleted,
//     required Function(String verificationId, [int forceResendingToken])
//         codeSent,
//     required Function(String error) verificationFailed,
//     required Function(String error) codeAutoRetrievalTimeout,
//   }) async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: verificationCompleted,
//       verificationFailed: (FirebaseAuthException authException) {
//         log("verification failed$authException");
//         verificationFailed("Verification Failed: ${authException.message}");
//       },
//       codeSent: (verificationId, forceResendingToken) {
//         log("verificationIdjdjd$verificationId");
//         codeSent(verificationId, forceResendingToken ?? 0);
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         codeAutoRetrievalTimeout(
//             "Code Auto Retrieval Timeout: $verificationId",);
//       },
//     );
//   }

//   Future<UserCredential> signInWithPhoneNumber({
//     required String verificationId,
//     required String smsCode,
//   }) async {
//     try {
//       AuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsCode,
//       );

//       return await _auth.signInWithCredential(credential);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   Stream<User?> get onAuthStateChanged {
//     return _auth.authStateChanges();
//   }
// }
