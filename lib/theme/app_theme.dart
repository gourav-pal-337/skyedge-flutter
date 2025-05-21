import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColorLight =
      //  Color(0xFF7DFF9B);
      const Color(0xFFA2D88F);
  // Color(0xFFA8FC99);
  static const Color primaryColorDark =
      // Color(0xFF7DFF9B);
      Color(0xFFA2D88F);
  // Color(0xFFA8FC99);

  static const Color secondaryColorLight = Color(0xFF03DAC6);
  static const Color secondaryColorDark = Color(0xFF03DAC6);

  static const Color errorColorLight = Color(0xFFCF6679);
  static const Color errorColorDark = Color(0xFFB00020);

  static const Color backgroundColorLight = Color(0xFFFAFAFA);
  static const Color backgroundColorDark = Color(0xFF121212);

  static const Color foregroundColorDark = Color(0xFFFAFAFA);
  static const Color foregroundColorLight = Color(0xFF121212);

  static const Color surfaceColorLight = Colors.white;
  static const Color surfaceColorDark = Color(0xFF1E1E1E);

  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.black;

  static const Color onSecondaryLight = Colors.black;
  static const Color onSecondaryDark = Colors.black;

  static const Color onBackgroundLight = Colors.black;
  static const Color onBackgroundDark = Colors.white;

  static const Color onSurfaceLight = Colors.black;
  static const Color onSurfaceDark = Colors.white;

  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Colors.black;

  static const Color blue = Color(0xFF0F60FF);
  static const Color blueRibbon = Color(0xFF88C7FF);

  static Color? grey = Colors.grey[300];
  static Color? greyText = Colors.grey[500];
  static Color? greenTextDark = Color(0xFF039855);

  static Color cardBackgroundColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ?
        // primaryColorDark.withOpacity(0.03)
        Color(0xFF282B31)
        : Color(0xFFF2F4F7);
  }

  static Color greenTextColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? primaryColorLight : Color(0xFF039855);
  }

  static Color blacktextColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white : Colors.black;
  }

  static Color whitetextColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return !isDark ? Colors.white : Colors.black;
  }

  static Color errorColor(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return !isDark ? errorColorLight : errorColorDark;
  }

  static bool isDarkMode(context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark;
  }

  // Theme Data
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColorLight,
        secondary: secondaryColorLight,
        error: errorColorLight,
        background: backgroundColorLight,
        surface: surfaceColorLight,
        onPrimary: onPrimaryLight,
        onSecondary: onSecondaryLight,
        onBackground: onBackgroundLight,
        onSurface: onSurfaceLight,
        onError: onErrorLight,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColorLight,
        foregroundColor: foregroundColorLight,
        elevation: 4,
      ),
      cardTheme: const CardTheme(
        color: surfaceColorLight,
        elevation: 2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: onPrimaryLight,
          backgroundColor: primaryColorLight,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColorLight,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColorLight,
          side: const BorderSide(color: primaryColorLight),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColorLight;
          }
          return Colors.grey;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColorLight.withOpacity(0.5);
          }
          return Colors.grey.withOpacity(0.5);
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.grey,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColorLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColorLight, width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: primaryColorLight),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: primaryColorDark,
        secondary: secondaryColorDark,
        error: errorColorDark,
        background: backgroundColorDark,
        surface: surfaceColorDark,
        onPrimary: onPrimaryDark,
        onSecondary: onSecondaryDark,
        onBackground: onBackgroundDark,
        onSurface: onSurfaceDark,
        onError: onErrorDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColorDark,
        foregroundColor: foregroundColorDark,
        elevation: 0,
      ),
      cardTheme: const CardTheme(
        color: surfaceColorDark,
        elevation: 4,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: onPrimaryDark,
          backgroundColor: primaryColorDark,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColorDark,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColorDark,
          side: const BorderSide(color: primaryColorDark),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColorDark;
          }
          return Colors.grey;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColorDark.withOpacity(0.5);
          }
          return Colors.grey.withOpacity(0.5);
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: Colors.grey,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColorDark, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: errorColorDark, width: 2),
        ),
        floatingLabelStyle: const TextStyle(color: primaryColorDark),
      ),
    );
  }
}
