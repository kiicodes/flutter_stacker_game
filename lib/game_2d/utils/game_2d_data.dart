import 'dart:ui';

import 'package:flame/components.dart';
import 'package:stacker_game/game_2d/game/filled_square_2d.dart';
import 'package:stacker_game/game_2d/game/game_2d.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class Game2DData {
  static int activeIndex = 0;
  static double gameWidth = 0;
  static double gameHeight = 0;
  static double startX = 0;
  static double startY = 0;
  static late int maxIndex;
  static int currentSpeed = 0;
  static late Paint squarePaint;
  static late int rowStartIndex;
  static late int rowEndIndex;
  // Current row indexes based on previous row indexes to stack in
  static List<int> expectedIndexes = List.empty(growable: true);
  // Indexes that already have a fixed square
  static List<int> filledIndexes = List.empty(growable: true);

  static void initValues(Vector2 size) {
    //SharedData.reset();
    //activeIndex = 0;
    //filledIndexes.clear();
    SharedData.onDimensionsSet(size.x, size.y);

    gameWidth = GameConfig.squareSize * SharedData.config.columns;
    final remainingWidth = size.x - gameWidth;
    startX = (remainingWidth / 2 + GameConfig.margin / 2) / 2;

    gameHeight = GameConfig.squareSize * SharedData.config.rows;
    final remainingHeight = size.y - gameHeight;
    startY = (remainingHeight / 2 + GameConfig.margin / 2);
    maxIndex = SharedData.config.rows * SharedData.config.columns;

    squarePaint = Paint()
    ..color = GameConfig.activeColor;
  }

  static void stop() {
    SharedData.stop();
  }

  static void start() {
    //SharedData.reset();
    activeIndex = 0;
    expectedIndexes.clear();
    filledIndexes.clear();
    SharedData.start();
    _updateRowIndexRange();
    currentSpeed = SharedData.calculateLevelSpeed();
  }

  static void _updateRowIndexRange() {
    rowStartIndex = SharedData.currentRow * SharedData.config.columns;
    rowEndIndex = rowStartIndex + SharedData.config.columns - 1;
  }

  static void placeInReversedSide(FilledSquare2D activeSquares) {
    bool someSquareAtStart = activeIndex == rowStartIndex || activeIndex - SharedData.currentSquareQuantity <= rowStartIndex;
    _updateRowIndexRange();
    if(!someSquareAtStart) {
      activeIndex = rowStartIndex;
      activeSquares.position = Game2DData.vectorFromIndex(activeIndex);
    } else {
      activeSquares.position = Game2DData.vectorFromIndex(rowEndIndex);
      activeIndex = rowEndIndex + SharedData.currentSquareQuantity - 1;
    }

    if(activeIndex > rowEndIndex) {
      activeSquares.squareIndex = rowEndIndex;
    } else {
      activeSquares.squareIndex = activeIndex;
    }
    activeSquares.quantity = 1;
  }

  static void changeRow(FilledSquare2D activeSquares, List<int> hitIndexes) {
    expectedIndexes.clear();
    for(int i = 0; i < hitIndexes.length; i++) {
      expectedIndexes.add(hitIndexes[i] + SharedData.config.columns);
    }

    SharedData.currentRow = SharedData.currentRow + 1;
    currentSpeed = SharedData.calculateLevelSpeed();
    placeInReversedSide(activeSquares);
  }

  static Vector2 vectorFromIndex(int index) {
    final reversedIndex = (SharedData.config.columns * SharedData.config.rows - 1) - index;
    final xy = _getPositionFromIndex(reversedIndex, SharedData.config.columns);
    final int x = xy[0];
    final int y = xy[1];
    return Vector2(startX + x * GameConfig.squareSize, startY + y * GameConfig.squareSize);
  }

  static List _getPositionFromIndex(int index, int columns) {
    final int column = index % columns;
    final int row = index ~/ columns;
    return [column, row];
  }

  static void moveValues() {
    int direction = SharedData.reversedMovement ? -1 : 1;
    bool reachedEndLimit = activeIndex + 2 > rowEndIndex + SharedData.currentSquareQuantity && !SharedData.reversedMovement;
    bool reachedStartLimit = activeIndex - 1 < rowStartIndex && SharedData.reversedMovement;
    bool reachedLimits = reachedEndLimit || reachedStartLimit;
    if(!reachedLimits) {
      activeIndex = activeIndex + direction;
    } else {
      SharedData.reversedMovement = !SharedData.reversedMovement;
      moveValues();
    }
  }
}