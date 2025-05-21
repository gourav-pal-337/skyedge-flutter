import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> checkInternetConnection() async {
  try {
    if (kIsWeb) {
      return _hasNetworkWeb();
    } else {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (kDebugMode) {
          print('connected');
        }
        return true;
      } else {
        return false;
      }
    }
  } on SocketException catch (_) {
    if (kDebugMode) {
      print('not connected');
    }
    return false;
  }
}

Future<bool> _hasNetworkWeb() async {
  // try {
  return true;
  //   final ApiResponse apiResponse =
  //       await ApiHitter().getApiResponse("www.google.com/");
  //   if (apiResponse.response?.statusCode == 200) return true;
  // } on SocketException catch (_) {}
  // return false;
// }
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

sendWhatsapp(String? text, dynamic number) async {
  var contact = "+91${9910257720}";
  var androidUrl = "whatsapp://send?phone=$contact&text=$text";
  var iosUrl = "https://wa.me/$contact?text=${Uri.parse(text ?? '')}";

  try {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
  } on Exception {
    throw Exception('Could not launch');
  }
}

double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

Future<FilePickerResult?> imageFromWeb() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: [
      'jpg',
      'png',
      'jpeg',
    ],
  );
  return result;
}

Future<String> imgFromCamera() async {
  XFile? image = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 50);
  return image!.path;
}

Future<String> imgFromGallery() async {
  XFile? image = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 50);
  return image!.path;
}

checkValidEmail(String email) {
  return RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(email);
}

// String getDate(String s) {
//   if (s.isNotEmpty) {
//     DateTime dateOfVisit = DateTime.parse(s);
//     return '${localeDateRange(DateFormat('d MMM').format(dateOfVisit))} ${dateOfVisit.year}';
//   }
//   return '';
// }

String roundDouble(double value) {
  // double mod = ;
  return ((value).round().toString());
}
