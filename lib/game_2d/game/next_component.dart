
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';

final buttonBgPaint = Paint()
  ..color =Colors.orange;

class NextComponent extends RectangleComponent with TapCallbacks {
  NextComponent({required Vector2 position, required Vector2 size}) : super(
      anchor: Anchor.center,
      paint: buttonBgPaint
  ) {
    this.position = position;
    this.size = size;
    final textComponent = TextComponent(
        text: "Next",
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        )
    );
    add(textComponent);
  }

  @override
  void onTapDown(TapDownEvent event) {
    print('Next tapped');
    event.continuePropagation = false;
    super.onTapDown(event);
  }
}