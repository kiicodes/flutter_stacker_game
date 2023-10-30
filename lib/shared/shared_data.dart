import 'package:stacker_game/shared/game_config.dart';

class SharedData {
  static final _levelSpeeds = [
    [600, 300],
    [500, 200],
    [350, 80]
  ];
  static late int level;
  static GameConfig config = const GameConfig();
  static late double blockSize;
  static late int currentBlockColumns;
  static const double margin = 20;

  static late int currentRow;
  static const startCol = 0;
  static late int currentCol;
  static late bool reversedMovement;
  static late bool started;

  static void initValues() {
    currentRow = 0;
    currentCol = startCol;
    level = 0;
    reversedMovement = false;
    started = false;
  }

  static void onDimensionsSet(double availableWidth, double availableHeight) {
    availableHeight = availableHeight - margin;
    availableWidth = availableWidth - margin;
    final byWidth = availableWidth / config.columns;
    final byHeight = availableHeight / config.rows;

    blockSize = byHeight > byWidth ? byWidth : byHeight;
  }

  static int calculatedLevelSpeed() {
    final speedRange = _levelSpeeds[SharedData.config.level];
    final step = (speedRange[0] - speedRange[1]) / (SharedData.config.rows - 1);
    final result = (speedRange[0] - currentRow * step).round();
    return result;
  }
  static void reset() {
    currentRow = 0;
    currentCol = SharedData.startCol;
    currentBlockColumns = config.blockColumns;
    level = 1;
  }

  static void start() {
    reset();
    SharedData.started = true;
  }

  static void stop() {
    started = false;
  }

  static void gameOver(bool won) {
    started = false;
  }
}