import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StringExtensions on String {
  Future<bool?> toast() => Fluttertoast.showToast(
        msg: this,
        textColor: Colors.white,
        backgroundColor: const Color(0xff141414),
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );

  String get getAbbreviation {
    // Split the name by space to get first and last names
    List<String> names = split(' ');

    // Check if the name contains at least two words
    if (names.length >= 2) {
      String firstName = names[0];
      String lastName = names[names.length -
          1]; // Get the last name (in case there are multiple names)

      // Get the first letter of the first and last names and capitalize them
      String initials = firstName[0].toUpperCase() + lastName[0].toUpperCase();

      return initials;
    } else if (names.isNotEmpty) {
      // If only the first name is provided, return its first letter capitalized
      return names[0][0].toUpperCase();
    } else {
      return '';
    }
  }

  String get getFirstName {
    List<String> names = split(' ');

    return names[0];
  }

  String get titleCase {
    return substring(0, 1).toUpperCase() + substring(1);
  }
}
