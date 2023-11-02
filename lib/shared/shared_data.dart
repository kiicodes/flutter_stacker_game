import 'package:stacker_game/shared/game_config.dart';

class SharedData {
  static GameConfig config = const GameConfig();
  static late int currentSquareQuantity;

  static late int currentRow;
  static late bool reversedMovement;
  static bool started = false;

  static void reset() {
    currentRow = 0;
    reversedMovement = false;
    started = false;
    currentSquareQuantity = config.squareQuantity;
  }

  static void onDimensionsSet(double availableWidth, double availableHeight) {
    availableHeight = availableHeight - GameConfig.margin;
    availableWidth = availableWidth - GameConfig.margin;
    final byWidth = availableWidth / config.columns;
    final byHeight = availableHeight / config.rows;

    // size of each game square (filled or not)
    GameConfig.squareSize = byHeight > byWidth ? byWidth : byHeight;
  }

  static int calculateLevelSpeed() {
    final speedRange = GameConfig.levelSpeeds[SharedData.config.level];
    // Divide speed range to rows to make each row faster than the previous one
    final step = (speedRange[0] - speedRange[1]) / (SharedData.config.rows - 1);
    // Get the speed for current row
    return (speedRange[0] - currentRow * step).round();
  }

  static void start() {
    reset();
    SharedData.started = true;
  }

  static void stop() {
    started = false;
  }

  static void gameOver() {
    stop();
  }
}