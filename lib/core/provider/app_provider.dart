import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String currentLocal = "en";
  ThemeMode currentTheme = ThemeMode.light;

  changeLanguage(String newLanguage) {
    if (currentLocal == newLanguage) return;
    currentLocal = newLanguage;
    notifyListeners();
  }

  bool isEnglish() {
    return currentLocal == "en";
  }

  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  bool isLight() {
    return currentTheme == ThemeMode.light;
  }
}
