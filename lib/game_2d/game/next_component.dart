
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_levels.dart';
import 'package:stacker_game/shared/shared_data.dart';

final buttonBgPaint = Paint()
  ..color =Colors.orange;

class NextComponent extends RectangleComponent with TapCallbacks {
  Function()? _onTap;
  NextComponent({required Vector2 position, required Vector2 size, required Function() onTap}) : super(
      anchor: Anchor.center,
      paint: buttonBgPaint
  ) {
    this.position = position;
    this.size = size;
    _onTap = onTap;
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
    GameLevels.currentLevel = GameLevels.currentLevel + 1;
    SharedData.config = GameLevels.levels[GameLevels.currentLevel];
    _onTap!();
    event.continuePropagation = false;
    super.onTapDown(event);
  }
}