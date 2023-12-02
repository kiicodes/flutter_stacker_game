import 'package:stacker_game/game_2d/game/next_component.dart';
import 'package:flame/components.dart';
import 'package:stacker_game/levels/game_levels.dart';

class LevelManager {
  static late NextComponent _nextComponent;

  static void initManager(Vector2 size, Function() onNext) {
    _nextComponent = NextComponent(
      position: Vector2(size.x / 2, size.y / 2 + 90),
      size: Vector2(120, 45),
      onTap: onNext
    );
  }

  static void showIfNeeded(List<Component> expendables, Component game) {
    if(GameLevels.currentLevel == GameLevels.levels.length - 1) {
      return;
    }

    expendables.add(_nextComponent);
    game.add(_nextComponent);
  }
}