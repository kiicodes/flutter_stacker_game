import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class NewRecord2D extends TextComponent {
  final totalTime = 0.8;
  final newRecordText = "New Record!";
  bool _showing = true;
  bool _isFirstTime = true;
  double _timeSpent = 0;
  NewRecord2D(Vector2 position)
      : super(
    position: position,
    anchor: Anchor.center,) {
    textRenderer = TextPaint(
      style: TextStyle(
        color: BasicPalette.green.color,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        shadows: const [
          Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 5.0,
            color: Colors.black,
          )
        ]
      )
    );
  }

  void updateBlink(double timeSpent) {
    if(_isFirstTime) {
      text = newRecordText;
      _isFirstTime = false;
    }
    _timeSpent += timeSpent;
    if(_timeSpent >= totalTime) {
      if(_showing) {
        text = "";
      } else {
        text = newRecordText;
      }
      _showing = !_showing;
      _timeSpent = 0;
    }
  }
}