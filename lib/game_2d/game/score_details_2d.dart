import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class ScoreDetails2D extends TextComponent {
  ScoreDetails2D(Vector2 position)
      : super(
    position: position,
    anchor: Anchor.center,) {
    textRenderer = TextPaint(
      style: TextStyle(
        color: BasicPalette.black.color,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        shadows: const [
          Shadow(
            offset: Offset(8.0, 8.0),
            blurRadius: 10.0,
            color: Colors.white,
          )
        ]
      )
    );
  }

  void updateText(double timeSpent, int lostSquares) {
    text = "\n(Time: 13.01s   Lost Squares: 1)";
  }
}