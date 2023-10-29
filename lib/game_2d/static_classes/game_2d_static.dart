// Moved by array indexes
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:stacker_game/game_classes/game_config.dart';
import 'package:stacker_game/static_classes/common_static.dart';

class Game2DStatic {
  static int activeIndex = 0;
  static double blockSize = 0;
  static double gameWidth = 0;
  static double startX = 0;
  static double gameHeight = 0;
  static double startY = 0;
  static late GameConfig gameConfig;
  static late int maxIndex;
  static int currentSpeed = 0;
  static late Paint blockPaint;
  static late int rowStartIndex;
  static late int rowEndIndex;
  static List<int> expectedIndexes = List.empty(growable: true);
  static List<int> filledIndexes = List.empty(growable: true);

  static void initValues(Vector2 size) {
    CommonStatic.configure(size.x, size.y);

    blockSize = CommonStatic.blockSize();
    gameConfig = CommonStatic.config();

    gameWidth = blockSize * gameConfig.columns;
    final remainingWidth = size.x - gameWidth;
    startX = (remainingWidth / 2 + CommonStatic.marginSize() / 2) / 2;

    gameHeight = blockSize * gameConfig.rows;
    final remainingHeight = size.y - gameHeight;
    startY = (remainingHeight / 2 + CommonStatic.marginSize() / 2);
    maxIndex = gameConfig.rows * gameConfig.columns;

    blockPaint = Paint()
    ..color = GameConfig.activeColor;
    CommonStatic.currentBlockColumns = CommonStatic.config().blockColumns;
  }

  static void start() {
    CommonStatic.start();
    CommonStatic.currentBlockColumns = CommonStatic.config().blockColumns;
    CommonStatic.currentRow = 0;
    _updateRowIndexRange();
    currentSpeed = CommonStatic.calculatedLevelSpeed();
    CommonStatic.started = true;
  }

  static void _updateRowIndexRange() {
    rowStartIndex = CommonStatic.currentRow * gameConfig.columns;
    rowEndIndex = rowStartIndex + gameConfig.columns - 1;
  }

  static void changeRow(int currentSize, List<int> hitIndexes) {
    if(CommonStatic.currentRow < gameConfig.rows - 1) {
      expectedIndexes.clear();
      for(int i = 0; i < hitIndexes.length; i++) {
        expectedIndexes.add(hitIndexes[i] + gameConfig.columns);
      }

      CommonStatic.currentRow = CommonStatic.currentRow + 1;
      activeIndex = rowStartIndex + gameConfig.columns - 1;
      _updateRowIndexRange();
      currentSpeed = CommonStatic.calculatedLevelSpeed();
    } else {
      CommonStatic.started = false;
    }
  }

  static Vector2 vectorFromIndex(int index) {
    final reversedIndex = (gameConfig.columns * gameConfig.rows - 1) - index;
    final xy = _getPositionFromIndex(reversedIndex, gameConfig.columns);
    final int x = xy[0];
    final int y = xy[1];
    return Vector2(startX + x * blockSize, startY + y * blockSize);
  }

  static List _getPositionFromIndex(int index, int columns) {
    final int column = index % columns;
    final int row = index ~/ columns;
    return [column, row];
  }


  static void move() {
    int direction = CommonStatic.reversedMovement ? -1 : 1;
    bool reachedEndLimit = activeIndex + 2 > rowEndIndex + CommonStatic.currentBlockColumns && !CommonStatic.reversedMovement;
    bool reachedStartLimit = activeIndex - 1 < rowStartIndex && CommonStatic.reversedMovement;
    bool reachedLimits = reachedEndLimit || reachedStartLimit;
    if(!reachedLimits) {
      activeIndex = activeIndex + direction;
    } else {
      CommonStatic.reversedMovement = !CommonStatic.reversedMovement;
      move();
    }
  }
}