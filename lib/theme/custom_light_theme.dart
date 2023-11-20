import 'package:flutter/material.dart';
import 'package:stacker_game/theme/app_colors.dart';

class CustomLightTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.defaultColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
      unselectedWidgetColor: const Color.fromRGBO(230, 230, 230, 1),
      textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Colors.black),
          bodySmall: TextStyle(
              color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: AppColors.defaultColor),
          titleSmall: TextStyle(
              color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.blue)));
  }
}
