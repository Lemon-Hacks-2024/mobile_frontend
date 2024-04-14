import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CustomThemeProvider extends ChangeNotifier {
  bool get isDarkMode => themeMode == ThemeMode.dark;

  ThemeMode _themeMode =
      ThemeMode.light; // Изначально используем системную тему

  CustomThemeProvider() {
    loadThemeMode(); // Загружаем сохраненную тему при создании объекта
  }

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    saveThemeMode(); // Сохраняем выбранную тему при изменении
    notifyListeners(); // Уведомляем слушателей об изменении темы
  }

  // Метод для загрузки сохраненной темы из SharedPreferences
  void loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt('is_night_mode');
    if (themeModeIndex != null) {
      _themeMode = ThemeMode.values[themeModeIndex];
      notifyListeners(); // Уведомляем слушателей об изменении темы
    }
  }

  // Метод для сохранения текущей темы в SharedPreferences
  void saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('is_night_mode', _themeMode.index);
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: mainClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: darkGrayClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: mainClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: darkGrayClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: mainClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  static final lightTheme = ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: mainClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: darkGrayClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: mainClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        color: darkGrayClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: mainClr,
        fontFamily: fontLato,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
