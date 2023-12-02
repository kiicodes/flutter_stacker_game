import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Stars2D extends PositionComponent with HasPaint {
  static Sprite? _starBorderImage;
  static Sprite? _starFilledImage;
  static List<SpriteComponent> _starsComponents = List.empty(growable: true);
  int _stars = 0;
  double starSize = 50;
  Stars2D(Vector2 position) : super(position: position, anchor: Anchor.center);

  void reset() {
    for(int i = 0; i < _starsComponents.length; i++) {
      remove(_starsComponents[i]);
    }
    _starsComponents.clear();
    _stars = 0;
  }

  Future<void> loadImagesIfNeeded() async {
    _starBorderImage ??= Sprite(await Flame.images.load('star_border.png'));
    _starFilledImage ??= Sprite(await Flame.images.load('star_filled.png'));
  }

  void addStar() {
    _stars++;
    size = Vector2(_stars * starSize, starSize);
    _starsComponents.add(
      SpriteComponent(
        sprite: _starFilledImage,
        position: Vector2((_stars - 1) * starSize, 0),
        size: Vector2(starSize, starSize)
      )
    );
    add(_starsComponents.last);
  }
}