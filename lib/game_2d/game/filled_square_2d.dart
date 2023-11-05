
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/utils/game_2d_data.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/game_2d/utils/fall_animation.dart';

final redPaint = Paint()
..color =Colors.red;


class FilledSquare2D extends RectangleComponent {
  int _quantity = 1;
  int _squareIndex = 0;
  FallAnimationItem? fallItem;

  FilledSquare2D(int quantity, int squareIndex)
      : super(
    position: Game2DData.vectorFromIndex(squareIndex),
    size: _fromQuantity(quantity),
    anchor: Anchor.topLeft,
    paint: Game2DData.squarePaint
  ) {
    _quantity = quantity;
    _squareIndex = squareIndex;
  }

  int get squareIndex => _squareIndex;

  set squareIndex(int newSquareIndex) {
    _squareIndex = newSquareIndex;
    position = Game2DData.vectorFromIndex(_squareIndex);
  }

  int get quantity => _quantity;

  set quantity(int quantityOfSquares) {
    _quantity = quantityOfSquares;
    size = _fromQuantity(quantity);
  }

  static Vector2 _fromQuantity(int quantity) {
    return quantity == 1 ? Vector2.all(GameConfig.squareSize) : Vector2(GameConfig.squareSize * quantity, GameConfig.squareSize);
  }
}