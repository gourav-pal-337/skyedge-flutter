import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  // * Get Age in days from Date of Birth:
  int get ageInDays => DateTime.now().difference(this).inDays;

  // * Get Age in months from Date of Birth:
  int get ageInMonths => DateTime.now().difference(this).inDays ~/ 30;

  // * Format age in days, months and years from age in days:
  String formattedAge() {
    // Calculate the difference between the current date and the date of birth
    final difference = DateTime.now().difference(this);

    // Calculate the age in days
    final int totalDays = difference.inDays;

    // Calculate the age in years, months, and days
    int years = totalDays ~/ 365;
    int remainingDays = totalDays % 365;

    // Calculate the number of months and remaining days
    int months = remainingDays ~/ 30;
    remainingDays %= 30;

    // Create a formatted string based on the calculated age
    final List<String> parts = [];

    if (years > 0) {
      parts.add('$years year${years > 1 ? 's' : ''}');
    }

    if (months > 0) {
      parts.add('$months month${months > 1 ? 's' : ''}');
    }

    if (remainingDays >= 0) {
      parts.add('$remainingDays day${remainingDays > 1 ? 's' : ''}');
    }

    // Join the parts into a single formatted string
    return parts.join(' ');
  }

  String formattedAgeShort() {
    return '${formattedAge().split(' ').first} ${formattedAge().split(' ')[1]}';
  }

  // * Get Formatted Date as "09 Apr":
  String get ddMM => DateFormat("dd MMM").format(this);

  String get ddMMYY => DateFormat("dd/MM/yyyy").format(this);

  String get getTimeHHMMa => DateFormat("hh:mm a").format(this);

  // * Get Formatted Date as "9th April 2024":
  String get ddSuffixMMM => DateFormat("d MMM")
      .format(this)
      .replaceFirst(" ", "${getDayOfMonthSuffix(day)} ");

  // * Get Formatted Date as "9th April 2024":
  String get ddSuffixMMYYYY => DateFormat("d MMM yyyy")
      .format(this)
      .replaceFirst(" ", "${getDayOfMonthSuffix(day)} ");

  // * Get Formatted Date as "9th April 2024, 04:30 PM":
  String get ddSuffixMMYYYYhhmm => DateFormat("d MMM yyyy, hh:mm a")
      .format(this)
      .replaceFirst(" ", "${getDayOfMonthSuffix(day)} ");

  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  // * Get time ago
  String timeAgo() {
    var timeAgo = "";
    final now = DateTime.now();
    final difference = now.difference(this);
    if (difference.inDays > 0) {
      timeAgo = "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      timeAgo = "${difference.inHours}h";
    } else if (difference.inMinutes > 0) {
      timeAgo = "${difference.inMinutes}m";
    } else if (difference.inSeconds > 0) {
      timeAgo = "${difference.inSeconds}s";
    } else {
      timeAgo = "just now";
    }
    return timeAgo;
  }

  // * Get time ago long ("3 days ago")
  String timeAgoLong() {
    var timeAgo = "";
    final now = DateTime.now();
    final difference = now.difference(this);
    if (difference.inDays > 0) {
      timeAgo = "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      timeAgo = "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      timeAgo = "${difference.inMinutes} minutes ago";
    } else if (difference.inSeconds > 0) {
      timeAgo = "${difference.inSeconds} seconds ago";
    } else {
      timeAgo = "just now";
    }
    return timeAgo;
  }
}
