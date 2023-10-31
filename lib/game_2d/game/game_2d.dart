import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/filled_square_2d.dart';
import 'package:stacker_game/game_2d/static_classes/fall_animation.dart';
import 'package:stacker_game/game_2d/static_classes/game_2d_static.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class Game2D extends FlameGame with TapCallbacks {
  FilledSquare2D? activeSquares;
  static List<Component> removeToNewGame = List.empty(growable: true);
  double myDt = 0;

  @override
  Future<void> onLoad() async {
    removeToNewGame.clear();
    Game2DStatic.initValues(size);
    add(
      BackgroundGrid2D(
        size,
        GameConfig.squareSize,
        SharedData.config,
        Game2DStatic.startX,
        Game2DStatic.startY,
        Game2DStatic.gameWidth,
        Game2DStatic.gameHeight
      )
    );
    activeSquares = FilledSquare2D(SharedData.currentSquareQuantity, Game2DStatic.vectorFromIndex(Game2DStatic.activeIndex), Game2DStatic.squarePaint);
  }

  @override
  void update(double dt) {
    if(SharedData.started || FallAnimation.items.isNotEmpty) {
      myDt = myDt + dt;
      if (myDt > Game2DStatic.currentSpeed / 1000.0) {
        FallAnimation.moveIt();
        if(SharedData.started) {
          Game2DStatic.move();
        }
        if (activeSquares != null) {
          int newIndex = Game2DStatic.activeIndex;
          if (newIndex > Game2DStatic.rowEndIndex) {
            final diff = Game2DStatic.rowEndIndex - newIndex;
            activeSquares!.changeSize(SharedData.currentSquareQuantity + diff);
            newIndex = Game2DStatic.rowEndIndex;
          } else if (newIndex - SharedData.currentSquareQuantity + 1 <
              Game2DStatic.rowStartIndex) {
            final newSize = newIndex + 1 - Game2DStatic.rowStartIndex;
            activeSquares!.changeSize(newSize);
          } else {
            activeSquares!.changeSize(SharedData.currentSquareQuantity);
          }
          activeSquares!.squareIndex = newIndex;
          /*Game2DStatic.activeIndex++;
          if (Game2DStatic.activeIndex == Game2DStatic.maxIndex) {
            Game2DStatic.activeIndex = 0;
          }*/
          activeSquares!.position = Game2DStatic.vectorFromIndex(newIndex);
        }
        myDt = 0;
      }
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!SharedData.started) {
      activeSquares!.position = Game2DStatic.vectorFromIndex(0);
      removeAll(removeToNewGame);
      removeToNewGame.clear();
      Game2DStatic.start();
      add(activeSquares!);
    } else {
      final List<int> hitIndexes = List.empty(growable: true);
      if(Game2DStatic.expectedIndexes.isNotEmpty) {
        for(int i = 0; i < activeSquares!.quantity; i++) {
          if(Game2DStatic.expectedIndexes.contains(activeSquares!.squareIndex - i)) {
            hitIndexes.add(activeSquares!.squareIndex - i);
          } else {
            add(FallAnimation.addItem(activeSquares!.squareIndex - i));
          }
        }
        if(hitIndexes.isNotEmpty) {
          final fixedSquare = FilledSquare2D(
              hitIndexes.length, Game2DStatic.vectorFromIndex(hitIndexes.first),
              Game2DStatic.squarePaint);
          removeToNewGame.add(fixedSquare);
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
        for(int i = 0; i < activeSquares!.quantity; i++) {
          hitIndexes.add(activeSquares!.squareIndex - i);
        }
        final fixedSquare = FilledSquare2D(activeSquares!.quantity, Game2DStatic.vectorFromIndex(Game2DStatic.activeIndex), Game2DStatic.squarePaint);
        removeToNewGame.add(fixedSquare);
        add(fixedSquare);
      }
      Game2DStatic.filledIndexes.addAll(hitIndexes);
      Game2DStatic.changeRow(activeSquares!.quantity, hitIndexes);
    }
  }

  void gameOver(bool won) {
    remove(activeSquares!);
    activeSquares!.position = Game2DStatic.vectorFromIndex(0);
    final style = TextStyle(
      color: won ? BasicPalette.yellow.color : BasicPalette.red.color,
      fontSize: 80.0, // Change the font size here
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
        position: Vector2(size.x / 2, size.y / 2),
        anchor: Anchor.center,
        textRenderer: regular
    );
    removeToNewGame.add(textComponent);
    add(textComponent);
    SharedData.gameOver();
  }
}

