import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class AnimatedStar extends SpriteComponent {
  final _timeToBigger = 0.8;
  final _timeToNormal = 0.4;
  final minSize = 5.0;
  double _timeSpent = 0;
  double _biggerSize = 0;
  double _maxSize = 0;
  AnimatedStar({required Vector2 size, required Vector2 position, CustomAppTheme? customAppTheme, required Sprite sprite})
      : super(position: position, size: size, sprite: sprite) {
    _maxSize = size.x;
    _biggerSize = _maxSize * 1.3;
    add(
      ColorEffect(
        Colors.orange,
        const Offset(
          0.0,
          1.0,
        ), // Means, applies from 0% to 50% of the color
        EffectController(
          duration: 1.5,
        ),
      )
    );
    reset();
  }

  void reset() {
    _timeSpent = 0;
    size = Vector2(minSize, minSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(_timeSpent > _timeToBigger + _timeToNormal) {
      return;
    }
    _timeSpent += dt;
    if(_timeSpent < _timeToBigger) {
      final sizeDiff = (_biggerSize - minSize) / 100;
      final currentStepPercent = _timeSpent / (_timeToBigger / 100);
      final newSize = minSize + (sizeDiff * currentStepPercent);
      size = Vector2(newSize, newSize);
    } else {
      final sizeDiff = (_biggerSize - _maxSize) / 100;
      final currentStepPercent = (_timeSpent - _timeToBigger) / (_timeToNormal / 100);
      final newSize = _biggerSize - (sizeDiff * currentStepPercent);
      size = Vector2(newSize, newSize);
    }
  }
}