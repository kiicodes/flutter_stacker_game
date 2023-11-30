import 'package:flutter/material.dart';

class CustomAppTheme extends ThemeExtension<CustomAppTheme> {
  final Color? gameBorderColor;
  final Color? gameBackgroundColor;
  final Color? gameEmptyBackgroundColor;
  final Color? activeColor;

  final Color? textColor;

  const CustomAppTheme({
    required this.gameBorderColor,
    required this.gameBackgroundColor,
    required this.gameEmptyBackgroundColor,
    required this.activeColor,
    required this.textColor,
  });

  @override
  ThemeExtension<CustomAppTheme> copyWith({
    Color? gameBorderColor, Color? gameBackgroundColor, Color? gameEmptyBackgroundColor,
    Color? activeColor, Color? textColor
  }) => CustomAppTheme(
    gameBorderColor: gameBorderColor ?? this.gameBorderColor,
    gameBackgroundColor: gameBackgroundColor ?? this.gameBackgroundColor,
    gameEmptyBackgroundColor: gameEmptyBackgroundColor ?? this.gameEmptyBackgroundColor,
    activeColor: activeColor ?? this.activeColor,
    textColor: textColor ?? this.textColor,
  );

  @override
  ThemeExtension<CustomAppTheme> lerp(covariant ThemeExtension<CustomAppTheme>? other, double t) {
    if(other is! CustomAppTheme) {
      return this;
    }
    
    return CustomAppTheme(
      gameBorderColor: Color.lerp(gameBorderColor, other.gameBorderColor, t),
      gameBackgroundColor: Color.lerp(gameBackgroundColor, other.gameBackgroundColor, t),
      gameEmptyBackgroundColor: Color.lerp(gameEmptyBackgroundColor, other.gameEmptyBackgroundColor, t),
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
    );
  }
}