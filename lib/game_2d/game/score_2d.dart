import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class Score2D extends TextComponent {
  final totalTime = 1.5;
  int _score = 0;
  double _timeSpent = 0;
  Score2D(Vector2 position, CustomAppTheme customAppTheme)
      : super(
      position: position,
      anchor: Anchor.center,) {
    textRenderer = TextPaint(
      style: TextStyle(
          color: customAppTheme.textColor,
          fontSize: 30.0,
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

  void setScore(int newScore) {
    _timeSpent = 0;
    _score = newScore;
  }

  bool updateScore(double timeSpent) {
    _timeSpent += timeSpent;
    if(_timeSpent >= totalTime) {
      text = "$_score pts";
      return false;
    }
    double easingFactor = _timeSpent / totalTime;
    double cubicEased = easingFactor * easingFactor * easingFactor;

    final calculated = (_score * cubicEased).toInt();
    text = "$calculated pts";
    return true;
  }
}