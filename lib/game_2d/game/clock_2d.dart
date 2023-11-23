import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Clock2D extends SpriteComponent {
  Clock2D(Sprite sprite, Vector2 position) : super(sprite: sprite, position: position, anchor: Anchor.center);
  static Future<Clock2D> create(Vector2 position) async {
    return Clock2D(Sprite(await Flame.images.load('clock.png')), position);
  }
}