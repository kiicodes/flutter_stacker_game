import 'package:flutter/material.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class CustomDarkTheme {
  static ThemeData getThemeData() {
    final base = ThemeData.dark(useMaterial3: true);
    Color blackColor = const Color.fromRGBO(15, 21, 25, 1);
    return base.copyWith(
        extensions: [
          CustomAppTheme(
            gameBorderColor: base.colorScheme.onPrimary,
            gameBackgroundColor: base.colorScheme.background,
            gameEmptyBackgroundColor: base.colorScheme.background,
            activeColor: const Color(0xFFFF6E40),
            textColor: base.colorScheme.primary,
          )
        ],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            // Makes all my ElevatedButton green
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color.fromRGBO(41, 57, 67, 1)),
          ),
        ),
        scaffoldBackgroundColor: blackColor,
        cardTheme: base.cardTheme.copyWith(
          color: const Color.fromRGBO(26, 35, 40, 1),
        ));
  }
}
