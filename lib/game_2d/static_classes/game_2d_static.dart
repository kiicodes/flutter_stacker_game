// Moved by array indexes
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class Game2DStatic {
  static int activeIndex = 0;
  static double gameWidth = 0;
  static double startX = 0;
  static double gameHeight = 0;
  static double startY = 0;
  static late int maxIndex;
  static int currentSpeed = 0;
  static late Paint blockPaint;
  static late int rowStartIndex;
  static late int rowEndIndex;
  static List<int> expectedIndexes = List.empty(growable: true);
  static List<int> filledIndexes = List.empty(growable: true);

  static void initValues(Vector2 size) {
    SharedData.initValues();
    activeIndex = 0;
    currentSpeed = 0;
    expectedIndexes.clear();
    filledIndexes.clear();
    SharedData.onDimensionsSet(size.x, size.y);

    gameWidth = GameConfig.blockSize * SharedData.config.columns;
    final remainingWidth = size.x - gameWidth;
    startX = (remainingWidth / 2 + SharedData.margin / 2) / 2;

    gameHeight = GameConfig.blockSize * SharedData.config.rows;
    final remainingHeight = size.y - gameHeight;
    startY = (remainingHeight / 2 + SharedData.margin / 2);
    maxIndex = SharedData.config.rows * SharedData.config.columns;

    blockPaint = Paint()
    ..color = GameConfig.activeColor;
  }

  static void start() {
    activeIndex = 0;
    expectedIndexes.clear();
    filledIndexes.clear();
    SharedData.start();
    SharedData.currentBlockColumns = SharedData.config.blockColumns;
    SharedData.currentRow = 0;
    _updateRowIndexRange();
    currentSpeed = SharedData.calculateLevelSpeed();
    SharedData.started = true;
  }

  static void _updateRowIndexRange() {
    rowStartIndex = SharedData.currentRow * SharedData.config.columns;
    rowEndIndex = rowStartIndex + SharedData.config.columns - 1;
  }

  static void changeRow(int currentSize, List<int> hitIndexes) {
    if(SharedData.currentRow < SharedData.config.rows - 1) {
      expectedIndexes.clear();
      for(int i = 0; i < hitIndexes.length; i++) {
        expectedIndexes.add(hitIndexes[i] + SharedData.config.columns);
      }

      SharedData.currentRow = SharedData.currentRow + 1;
      activeIndex = rowStartIndex + SharedData.config.columns - 1;
      _updateRowIndexRange();
      currentSpeed = SharedData.calculateLevelSpeed();
    } else {
      SharedData.started = false;
    }
  }

  static Vector2 vectorFromIndex(int index) {
    final reversedIndex = (SharedData.config.columns * SharedData.config.rows - 1) - index;
    final xy = _getPositionFromIndex(reversedIndex, SharedData.config.columns);
    final int x = xy[0];
    final int y = xy[1];
    return Vector2(startX + x * GameConfig.blockSize, startY + y * GameConfig.blockSize);
  }

  static List _getPositionFromIndex(int index, int columns) {
    final int column = index % columns;
    final int row = index ~/ columns;
    return [column, row];
  }


  static void move() {
    int direction = SharedData.reversedMovement ? -1 : 1;
    bool reachedEndLimit = activeIndex + 2 > rowEndIndex + SharedData.currentBlockColumns && !SharedData.reversedMovement;
    bool reachedStartLimit = activeIndex - 1 < rowStartIndex && SharedData.reversedMovement;
    bool reachedLimits = reachedEndLimit || reachedStartLimit;
    if(!reachedLimits) {
      activeIndex = activeIndex + direction;
    } else {
      SharedData.reversedMovement = !SharedData.reversedMovement;
      move();
    }
  }
}