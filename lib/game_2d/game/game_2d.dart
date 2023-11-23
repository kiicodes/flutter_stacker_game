import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/clock_2d.dart';
import 'package:stacker_game/game_2d/game/filled_square_2d.dart';
import 'package:stacker_game/game_2d/game/score_2d.dart';
import 'package:stacker_game/game_2d/utils/fall_animation.dart';
import 'package:stacker_game/game_2d/utils/game_2d_data.dart';
import 'package:stacker_game/shared/game_levels.dart';
import 'package:stacker_game/shared/shared_data.dart';

class Game2D extends FlameGame with TapCallbacks {
  late FilledSquare2D movingSquares;
  static List<Component> expendables = List.empty(growable: true);
  double myDt = 0;
  late TextComponent tip;
  late Clock2D _clock2d;
  late Score2D _scoreComponent;
  bool _showingScore = false;

  @override
  Future<void> onLoad() async {
    initTipComponent();
    _clock2d = await Clock2D.create(Vector2(size.x / 2, size.y / 2 + 10));
    _scoreComponent = Score2D(Vector2(size.x / 2, size.y / 2 + 50));
    Game2DData.initValues(size);
    add(BackgroundGrid2D(size));
    add(tip);
    movingSquares = FilledSquare2D(1, 0);
  }

  @override
  void update(double dt) {
    if(_showingScore) {
      _showingScore = _scoreComponent.updateScore(dt);
    }

    if(!SharedData.started && FallAnimation.items.isEmpty) {
      super.update(dt);
      return;
    }

    myDt = myDt + dt;
    if(myDt < Game2DData.currentSpeed / 1000.0) {
      super.update(dt);
      return;
    }

    myDt = 0;
    FallAnimation.moveIt();
    if(!SharedData.started) {
      super.update(dt);
      return;
    }

    Game2DData.moveValues();
    cutSquaresIfNeeded();

    super.update(dt);
  }

  void cutSquaresIfNeeded() {
    int newIndex = Game2DData.activeIndex;
    final squarePassedEnd = newIndex > Game2DData.rowEndIndex;
    final squarePassedStart = newIndex - SharedData.currentSquareQuantity + 1 < Game2DData.rowStartIndex;
    if (squarePassedEnd) {
      final subtractSquares = Game2DData.rowEndIndex - newIndex;
      movingSquares.quantity = SharedData.currentSquareQuantity + subtractSquares;
      newIndex = Game2DData.rowEndIndex;
    } else if (squarePassedStart) {
      final newSize = newIndex + 1 - Game2DData.rowStartIndex;
      movingSquares.quantity = newSize;
    } else {
      movingSquares.quantity = SharedData.currentSquareQuantity;
    }
    movingSquares.squareIndex = newIndex;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!SharedData.started) {
      myDt = 0;
      movingSquares.squareIndex = 0;
      movingSquares.quantity = 1;
      if(expendables.isNotEmpty) {
        removeAll(expendables);
        expendables.clear();
      }
      Game2DData.start();
      add(movingSquares);
    } else {
      final List<int> hitIndexes = List.empty(growable: true);
      if(SharedData.currentRow > 0) {
        for (int i = 0; i < movingSquares.quantity; i++) {
          if (Game2DData.expectedIndexes.contains(
              movingSquares.squareIndex - i)) {
            hitIndexes.add(movingSquares.squareIndex - i);
          } else {
            add(FallAnimation.addItem(movingSquares.squareIndex - i));
          }
        }
        if(hitIndexes.isNotEmpty) {
          final fixedSquare = FilledSquare2D(
            hitIndexes.length,
            hitIndexes.first,
          );
          expendables.add(fixedSquare);
          add(fixedSquare);
          SharedData.currentSquareQuantity = hitIndexes.length;
        } else {
          gameOver(false);
          return;
        }
        if(SharedData.currentRow + 1 == SharedData.config.rows) {
          gameOver(true);
          return;
        }
      } else {
        // first row is automatically a hit
        for(int i = 0; i < movingSquares.quantity; i++) {
          hitIndexes.add(movingSquares.squareIndex - i);
        }
        SharedData.currentSquareQuantity = movingSquares.quantity;
        final fixedSquare = FilledSquare2D(hitIndexes.length, hitIndexes.first);
        expendables.add(fixedSquare);
        add(fixedSquare);
      }
      Game2DData.filledIndexes.addAll(hitIndexes);
      myDt = 0;
      Game2DData.changeRow(movingSquares, hitIndexes);
    }
    updateTipText();
  }

  void stop() {
    expendables.clear();
    Game2DData.stop();
  }

  void gameOver(bool won) {
    if(won && GameLevels.currentLevel + 1 > GameLevels.maxEnabledLevel) {
      GameLevels.maxEnabledLevel = GameLevels.currentLevel + 1;
      SharedPreferences.getInstance().then((value) => value.setInt('currentLevel', GameLevels.maxEnabledLevel));
    }
    remove(movingSquares);
    final style = TextStyle(
      color: won ? BasicPalette.yellow.color : BasicPalette.red.color,
      fontSize: 70.0,
      fontWeight: FontWeight.bold,
      shadows: const [
        Shadow(
          offset: Offset(8.0, 8.0),
          blurRadius: 10.0,
          color: Colors.black,
        )
      ]
    );
    final regular = TextPaint(style: style);
    final textComponent = TextComponent(
      text: won ? "Winner!" : "You Lose!",
      position: Vector2(size.x / 2, size.y / 2.5),
      anchor: Anchor.center,
      textRenderer: regular
    );
    expendables.add(textComponent);
    expendables.add(_scoreComponent);
    expendables.add(_clock2d);
    add(textComponent);
    _scoreComponent.setScore(2000);
    add(_scoreComponent);
    add(_clock2d);
    _showingScore = true;
    SharedData.gameOver();
    updateTipText();
  }

  void initTipComponent() {
    final style = TextStyle(
      color: BasicPalette.black.color,
      fontSize: 20.0,
    );
    tip = TextComponent(
      text: "",
      position: Vector2(size.x / 2, 20),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: style)
    );
    updateTipText();
  }

  void updateTipText() {
    if(SharedData.started) {
      tip.text = "Tap to Stack";
    } else {
      tip.text = "Tap to Start";
    }
  }
}

