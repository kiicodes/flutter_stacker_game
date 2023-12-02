import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class ScoreDetails2D extends TextComponent {
  ScoreDetails2D(Vector2 position, CustomAppTheme customAppTheme)
      : super(
    position: position,
    anchor: Anchor.center,) {
    textRenderer = TextPaint(
      style: TextStyle(
        color: customAppTheme.textColor,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: const Offset(8.0, 8.0),
            blurRadius: 10.0,
            color: customAppTheme.gameEmptyBackgroundColor!,
          )
        ]
      )
    );
  }

  void updateText(String timeSpent) {
    final lostSquares = SharedData.config.squareQuantity - SharedData.currentSquareQuantity;
    text = "\n(Time: ${timeSpent}   Lost Squares: $lostSquares)";
  }
}