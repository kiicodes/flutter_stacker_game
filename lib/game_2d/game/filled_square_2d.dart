
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/game_2d/utils/fall_animation.dart';

final redPaint = Paint()
..color =Colors.red;


class FilledSquare2D extends RectangleComponent {
  int quantity;
  int squareIndex = 0;
  FallAnimationItem? fallItem;

  FilledSquare2D(this.quantity, Vector2 position, Paint squarePaint)
      : super(
    position: position,
    size: quantity == 1 ? Vector2.all(GameConfig.squareSize) : Vector2(GameConfig.squareSize * quantity, GameConfig.squareSize),
    anchor: Anchor.topLeft,
    paint: squarePaint
  );

  void changeSize(int quantityOfSquares) {
    quantity = quantityOfSquares;
    size = quantityOfSquares == 1 ? Vector2.all(GameConfig.squareSize) : Vector2(GameConfig.squareSize * quantityOfSquares, GameConfig.squareSize);
  }
}