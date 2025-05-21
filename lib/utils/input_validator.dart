class Validators {
  static String? phoneNumberValidator(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      "Please enter a phone number";
    }

    // Remove non-numeric characters to validate pure digits
    final numericValue = value?.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericValue!.length < 10) {
      return "Please enter a valid phone number";
    }

    return null; // Return null to indicate no error
  }

  // Custom email validation function for TextFormField
  // Returns an error message if the email is invalid or null, or null if the email is valid.
  static String? validateEmail(String? value, bool isRequired) {
    // Check if the email value is null
    if (value == null || value.isEmpty) {
      return isRequired
          ? 'Email is required'
          : null; // if string is empty : Return an error message if email is required, else return null
    }

    // Regular expression to match a valid email format
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    // Check if the email value matches the email format
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address'; // Return an error message if the email format is invalid
    }

    return null; // Return null if the email is valid
  }

  static String? validateIndianVehicleNumber(String? value) {
    bool isIndianVehicleNumber(String vehicleNumber) {
      // Define a regular expression for Indian vehicle numbers
      RegExp regex =
          RegExp(r'^[A-Z]{2}[0-9]{1,2}(?:[A-Z])?(?:[A-Z]*)?[0-9]{4}$');

      // Check if the provided vehicle number matches the pattern
      return regex.hasMatch(vehicleNumber.toUpperCase());
    }

    if (value?.isNotEmpty != true) {
      return 'Please enter a vehicle number';
    } else if (!isIndianVehicleNumber(value ?? '')) {
      return 'Please provide a valid Indian vehicle number';
    }

    return null;
  }

  static String? commonValidator(String? value, {String fieldname = 'value'}) {
    if (value?.isEmpty ?? true) {
      return 'Please enter $fieldname';
    }
    return null;
  }

  // static String? validateAdhaar(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Aadhaar number is required';
  //   }

  //   // Remove non-numeric characters to validate pure digits
  //   final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

  //   if (numericValue.length != 12) {
  //     return 'Aadhaar number must be 12 digits';
  //   }

  //   return null; // Return null to indicate no error
  // }

  // static String? validatePanCard(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'PAN number is required';
  //   }

  //   final panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

  //   if (!panRegExp.hasMatch(value.toUpperCase())) {
  //     return 'Invalid PAN card number';
  //   }

  //   return null; // Return null to indicate no error
  // }
}
