import 'package:stacker_game/shared/game_config.dart';

class SharedData {
  static final _levelSpeeds = [
    [600, 300],
    [500, 200],
    [350, 80]
  ];
  static GameConfig config = const GameConfig();
  static double blockSize = 0;
  static const double _margin = 20;
  static int currentRow = 0;
  static const startCol = 0;
  static int currentCol = startCol;
  static int level = 1;
  static bool reversedMovement = false;
  static bool started = false;
  static int currentBlockColumns = 0;

  static void initValues() {
    currentRow = 0;
    currentCol = startCol;
    level = 1;
    reversedMovement = false;
    started = false;
  }

  static void onDimensionsSet(double availableWidth, double availableHeight) {
    availableHeight = availableHeight - _margin;
    availableWidth = availableWidth - _margin;
    final byWidth = availableWidth / config.columns;
    final byHeight = availableHeight / config.rows;

    blockSize = byHeight > byWidth ? byWidth : byHeight;
  }

  static double marginSize() {
    return _margin;
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