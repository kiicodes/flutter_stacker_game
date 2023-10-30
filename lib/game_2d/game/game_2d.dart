import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/filled_block_2d.dart';
import 'package:stacker_game/game_2d/static_classes/fall_animation.dart';
import 'package:stacker_game/game_2d/static_classes/game_2d_static.dart';
import 'package:stacker_game/shared/shared_data.dart';

class Game2D extends FlameGame with TapCallbacks {
  FilledBlock2D? activeBlock;
  static List<Component> removeToNewGame = List.empty(growable: true);
  double myDt = 0;

  @override
  Future<void> onLoad() async {
    removeToNewGame.clear();
    Game2DStatic.initValues(size);
    add(
      BackgroundGrid2D(
        size,
        Game2DStatic.blockSize,
        Game2DStatic.gameConfig,
        Game2DStatic.startX,
        Game2DStatic.startY,
        Game2DStatic.gameWidth,
        Game2DStatic.gameHeight
      )
    );
    activeBlock = FilledBlock2D(SharedData.currentBlockColumns, Game2DStatic.vectorFromIndex(Game2DStatic.activeIndex), Game2DStatic.blockPaint);
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
        if (activeBlock != null) {
          int newIndex = Game2DStatic.activeIndex;
          if (newIndex > Game2DStatic.rowEndIndex) {
            final diff = Game2DStatic.rowEndIndex - newIndex;
            activeBlock!.changeSize(SharedData.currentBlockColumns + diff);
            newIndex = Game2DStatic.rowEndIndex;
          } else if (newIndex - SharedData.currentBlockColumns + 1 <
              Game2DStatic.rowStartIndex) {
            final newSize = newIndex + 1 - Game2DStatic.rowStartIndex;
            activeBlock!.changeSize(newSize);
          } else {
            activeBlock!.changeSize(SharedData.currentBlockColumns);
          }
          activeBlock!.blockIndex = newIndex;
          /*Game2DStatic.activeIndex++;
          if (Game2DStatic.activeIndex == Game2DStatic.maxIndex) {
            Game2DStatic.activeIndex = 0;
          }*/
          activeBlock!.position = Game2DStatic.vectorFromIndex(newIndex);
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
      activeBlock!.position = Game2DStatic.vectorFromIndex(0);
      removeAll(removeToNewGame);
      removeToNewGame.clear();
      Game2DStatic.start();
      add(activeBlock!);
    } else {
      final List<int> hitIndexes = List.empty(growable: true);
      if(Game2DStatic.expectedIndexes.isNotEmpty) {
        for(int i = 0; i < activeBlock!.quantity; i++) {
          if(Game2DStatic.expectedIndexes.contains(activeBlock!.blockIndex - i)) {
            hitIndexes.add(activeBlock!.blockIndex - i);
          } else {
            add(FallAnimation.addItem(activeBlock!.blockIndex - i));
          }
        }
        if(hitIndexes.isNotEmpty) {
          final fixedBlock = FilledBlock2D(
              hitIndexes.length, Game2DStatic.vectorFromIndex(hitIndexes.first),
              Game2DStatic.blockPaint);
          removeToNewGame.add(fixedBlock);
          add(fixedBlock);
          SharedData.currentBlockColumns = hitIndexes.length;
        } else {
          gameOver(false);
          return;
        }
        if(SharedData.currentRow + 1 == Game2DStatic.gameConfig.rows) {
          gameOver(true);
          return;
        }
      } else {
        for(int i = 0; i < activeBlock!.quantity; i++) {
          hitIndexes.add(activeBlock!.blockIndex - i);
        }
        final fixedBlock = FilledBlock2D(activeBlock!.quantity, Game2DStatic.vectorFromIndex(Game2DStatic.activeIndex), Game2DStatic.blockPaint);
        removeToNewGame.add(fixedBlock);
        add(fixedBlock);
      }
      Game2DStatic.filledIndexes.addAll(hitIndexes);
      Game2DStatic.changeRow(activeBlock!.quantity, hitIndexes);
    }
  }

  void gameOver(bool won) {
    remove(activeBlock!);
    activeBlock!.position = Game2DStatic.vectorFromIndex(0);
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
    SharedData.gameOver(won);
  }
}

