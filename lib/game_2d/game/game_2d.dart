import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/filled_square_2d.dart';
import 'package:stacker_game/game_2d/utils/fall_animation.dart';
import 'package:stacker_game/game_2d/utils/game_2d_data.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class Game2D extends FlameGame with TapCallbacks {
  FilledSquare2D? activeSquares;
  static List<Component> removeToNewGame = List.empty(growable: true);
  double myDt = 0;

  @override
  Future<void> onLoad() async {
    removeToNewGame.clear();
    Game2DData.initValues(size);
    add(
      BackgroundGrid2D(
        size,
        GameConfig.squareSize,
        SharedData.config,
        Game2DData.startX,
        Game2DData.startY,
        Game2DData.gameWidth,
        Game2DData.gameHeight
      )
    );
    activeSquares = FilledSquare2D(SharedData.currentSquareQuantity, Game2DData.vectorFromIndex(Game2DData.activeIndex), Game2DData.squarePaint);
  }

  @override
  void update(double dt) {
    if(SharedData.started || FallAnimation.items.isNotEmpty) {
      myDt = myDt + dt;
      if (myDt > Game2DData.currentSpeed / 1000.0) {
        FallAnimation.moveIt();
        if(SharedData.started) {
          Game2DData.move();
        }
        if (activeSquares != null) {
          int newIndex = Game2DData.activeIndex;
          if (newIndex > Game2DData.rowEndIndex) {
            final diff = Game2DData.rowEndIndex - newIndex;
            activeSquares!.changeSize(SharedData.currentSquareQuantity + diff);
            newIndex = Game2DData.rowEndIndex;
          } else if (newIndex - SharedData.currentSquareQuantity + 1 <
              Game2DData.rowStartIndex) {
            final newSize = newIndex + 1 - Game2DData.rowStartIndex;
            activeSquares!.changeSize(newSize);
          } else {
            activeSquares!.changeSize(SharedData.currentSquareQuantity);
          }
          activeSquares!.squareIndex = newIndex;
          /*Game2DStatic.activeIndex++;
          if (Game2DStatic.activeIndex == Game2DStatic.maxIndex) {
            Game2DStatic.activeIndex = 0;
          }*/
          activeSquares!.position = Game2DData.vectorFromIndex(newIndex);
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
      activeSquares!.position = Game2DData.vectorFromIndex(0);
      activeSquares!.changeSize(1);
      removeAll(removeToNewGame);
      removeToNewGame.clear();
      Game2DData.start();
      add(activeSquares!);
    } else {
      final List<int> hitIndexes = List.empty(growable: true);
      if(Game2DData.expectedIndexes.isNotEmpty) {
        for(int i = 0; i < activeSquares!.quantity; i++) {
          if(Game2DData.expectedIndexes.contains(activeSquares!.squareIndex - i)) {
            hitIndexes.add(activeSquares!.squareIndex - i);
          } else {
            add(FallAnimation.addItem(activeSquares!.squareIndex - i));
          }
        }
        if(hitIndexes.isNotEmpty || SharedData.currentRow == 0) {
          FilledSquare2D fixedSquare;
          if(SharedData.currentRow == 0) {
            hitIndexes.clear();
            for(int i = activeSquares!.squareIndex; i > activeSquares!.squareIndex - activeSquares!.quantity; i--) {
              hitIndexes.add(i);
            }
          }
          fixedSquare = FilledSquare2D(
              hitIndexes.length, Game2DData.vectorFromIndex(hitIndexes.first),
              Game2DData.squarePaint);
          removeToNewGame.add(fixedSquare);
          add(fixedSquare);
          if(SharedData.currentRow == 0) {
            SharedData.currentSquareQuantity = activeSquares!.quantity;
          } else {
            SharedData.currentSquareQuantity = hitIndexes.length;
          }
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
        final fixedSquare = FilledSquare2D(activeSquares!.quantity, Game2DData.vectorFromIndex(Game2DData.activeIndex), Game2DData.squarePaint);
        removeToNewGame.add(fixedSquare);
        add(fixedSquare);
      }
      Game2DData.filledIndexes.addAll(hitIndexes);
      myDt = 0;
      Game2DData.changeRow(activeSquares!, hitIndexes);
    }
  }

  void gameOver(bool won) {
    remove(activeSquares!);
    activeSquares!.position = Game2DData.vectorFromIndex(0);
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

