import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  /// data elly lma 7tt8ye 7t2sr 3la 2ktr mn widget
  /// wel function ely 7t8yr
  String appLanguage = 'en';
  ThemeMode appMode = ThemeMode.light;

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      ///comparison
      return;
    }

    appLanguage = newLanguage;

    ///bn7ot ely fe yameen fe 4mal assignment operator
    notifyListeners();

    ///byb3t notification le 27 7ad by listen 3la provider fa etsrf 23ml action
  }

  ///lazm b3d 2y data n3ml notify
  void changeTheme(ThemeMode newMode) {
    if (appMode == newMode) {
      return;
    }
    appMode = newMode;
    notifyListeners();
  }

  bool isDarkMode() {
    return appMode == ThemeMode.dark;
  }
}
