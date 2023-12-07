import 'package:flutter/material.dart';
import 'package:stacker_game/theme/app_colors.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class CustomLightTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      extensions: const [
        CustomAppTheme(
          gameBorderColor: Color(0xFFD0E0E3),
          gameBackgroundColor:  Color(0xFFECEFF1),
          gameEmptyBackgroundColor: Colors.white,
          activeColor: Color.fromRGBO(252, 86, 51, 1),
          textColor: Colors.black,
        )
      ],
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
