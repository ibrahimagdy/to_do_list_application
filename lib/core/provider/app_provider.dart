import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  String currentLocal = "en";
  ThemeMode currentTheme = ThemeMode.light;
  SharedPreferences prefs;

  AppProvider(this.prefs) {
    currentLocal = prefs.getString("language") ?? "en";
    bool tempMode = prefs.getBool("theme") ?? true;
    if (tempMode) {
      currentTheme = ThemeMode.light;
    } else {
      currentTheme = ThemeMode.dark;
    }
  }

  changeLanguage(String newLanguage) {
    currentLocal = newLanguage;
    prefs.setString("language", newLanguage);
    notifyListeners();
  }

  bool isEnglish() {
    return currentLocal == "en";
  }

  changeTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    prefs.setBool("theme", newTheme == ThemeMode.light ? true : false);
    notifyListeners();
  }

  bool isLight() {
    return currentTheme == ThemeMode.light;
  }

  String splashScreenImage() {
    return isLight()
        ? "assets/images/splash_screen.png"
        : "assets/images/splash_screen_dark.png";
  }
}