
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:stacker_game/game_2d/static_classes/fall_animation.dart';

final redPaint = Paint()
..color =Colors.red;


class FilledBlock2D extends RectangleComponent {
  int quantity;
  int blockIndex = 0;
  FallAnimationItem? fallItem;

  FilledBlock2D(this.quantity, Vector2 position, Paint blockPaint)
      : super(
    position: position,
    size: quantity == 1 ? Vector2.all(GameConfig.blockSize) : Vector2(GameConfig.blockSize * quantity, GameConfig.blockSize),
    anchor: Anchor.topLeft,
    paint: blockPaint
  );

  void changeSize(int quantityOfBlocks) {
    quantity = quantityOfBlocks;
    size = quantityOfBlocks == 1 ? Vector2.all(GameConfig.blockSize) : Vector2(GameConfig.blockSize * quantityOfBlocks, GameConfig.blockSize);
  }
}