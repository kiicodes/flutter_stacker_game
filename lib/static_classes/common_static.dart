import 'package:stacker_game/game_classes/game_config.dart';

class CommonStatic {
  static final _levelSpeeds = [
    [600, 300],
    [500, 200],
    [350, 80]
  ];
  static GameConfig _config = const GameConfig();
  static double _availableHeight = 0;
  static double _availableWidth = 0;
  static const double _margin = 20;
  static int currentRow = 0;
  static const startCol = 0;
  static int currentCol = startCol;
  static int level = 1;
  static bool reversedMovement = false;
  static bool started = false;
  static int currentBlockColumns = 0;

  static void configure(double availableWidth, double availableHeight) {
    _availableHeight = availableHeight - _margin;
    _availableWidth = availableWidth - _margin;
  }

  static GameConfig config() {
    return _config;
  }

  static void setConfig(GameConfig newConfig) {
    _config = newConfig;
  }

  static double blockSize() {
    final byWidth = _availableWidth / _config.columns;
    final byHeight = _availableHeight / _config.rows;

    return byHeight > byWidth ? byWidth : byHeight;
  }

  static double marginSize() {
    return _margin;
  }

  static int calculatedLevelSpeed() {
    final speedRange = _levelSpeeds[CommonStatic.config().speed];
    final step = (speedRange[0] - speedRange[1]) / (CommonStatic.config().rows - 1);
    final result = (speedRange[0] - currentRow * step).round();
    print('Speed $result');
    return result;
  }
  static void reset() {
    currentRow = 0;
    currentCol = CommonStatic.startCol;
    currentBlockColumns = _config.blockColumns;
    level = 1;
  }

  static void start() {
    reset();
    CommonStatic.started = true;
  }

  static void stop() {
    started = false;
  }

  static void gameOver(bool won) {
    started = false;
  }
}