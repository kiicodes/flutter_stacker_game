import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/static_classes/common_static.dart';

final redPaint = Paint()
..color =Colors.red;


class FilledBlock2D extends RectangleComponent {
  FilledBlock2D(int quantity, Vector2 position, Paint blockPaint)
      : super(
    position: position,
    size: quantity == 1 ? Vector2.all(CommonStatic.blockSize()) : Vector2(CommonStatic.blockSize() * quantity, CommonStatic.blockSize()),
    anchor: Anchor.topLeft,
    paint: blockPaint
  );

  void changeSize(int quantityOfBlocks) {
    size = quantityOfBlocks == 1 ? Vector2.all(CommonStatic.blockSize()) : Vector2(CommonStatic.blockSize() * quantityOfBlocks, CommonStatic.blockSize());
  }
}