import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  // Get the current brightness (light or dark)
  Brightness get currentBrightness {
    // If not using system theme, return brightness based on selected theme
    if (_themeMode == ThemeMode.light) return Brightness.light;
    if (_themeMode == ThemeMode.dark) return Brightness.dark;

    // If using system theme, get the platform brightness
    return SchedulerBinding.instance.platformDispatcher.platformBrightness;
  }

  // Check if the current theme is dark
  bool get isDarkMode {
    return currentBrightness == Brightness.dark;
  }

  // Constructor loads the saved theme mode
  ThemeProvider() {
    _loadThemeMode();
  }

  // Load theme mode from shared preferences
  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeModeString = prefs.getString('themeMode') ?? 'system';

    switch (themeModeString) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  // Save and update theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String modeToSave;

    switch (mode) {
      case ThemeMode.light:
        modeToSave = 'light';
        break;
      case ThemeMode.dark:
        modeToSave = 'dark';
        break;
      default:
        modeToSave = 'system';
    }

    await prefs.setString('themeMode', modeToSave);
  }
}
