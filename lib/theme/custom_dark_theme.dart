import 'package:flutter/material.dart';

class CustomDarkTheme {
  static ThemeData getThemeData() {
    final base = ThemeData.dark(useMaterial3: true);
    Color blackColor = const Color.fromRGBO(15, 21, 25, 1);
    //        backgroundColor: blackColor,
    //         canvasColor: blackColor,
    return base.copyWith(
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
