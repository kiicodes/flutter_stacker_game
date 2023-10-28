import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/static_classes/game_static.dart';

final redPaint = Paint()
..color =Colors.red;


class FilledBlock2D extends RectangleComponent {
  FilledBlock2D(Vector2 position)
      : super(
    position: position,
    size: Vector2.all(GameStatic.blockSize()),
    anchor: Anchor.topLeft,
    paint: redPaint
  );
}