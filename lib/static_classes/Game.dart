import 'package:stacker_game/game_classes/game_config.dart';

class Game {
  static final _startCol = 0;
  static GameConfig _config = const GameConfig();
  static List<int>? _blockState;
  static int _currentRow = 0;
  static int _currentCol = _startCol;
  static double _availableHeight = 0;
  static double _availableWidth = 0;
  static bool _started = false;
  static bool _reversedMovement = false;

  static void configure(double availableWidth, double availableHeight) {
    _availableHeight = availableHeight;
    _availableWidth = availableWidth;
  }

  static double blockSize() {
    if(_availableWidth < _availableHeight) {
      return _availableWidth / _config.columns;
    } else {
      return _availableHeight / _config.rows;
    }
  }

  static List<int> items() {
    if(_blockState == null) {
      _blockState = List.empty(growable: true);
      for(int i = 0; i < countItems(); i++) {
        _blockState!.add(0);
      }
    }
    return _blockState!;
  }

  static GameConfig config() {
    return _config;
  }

  static int countItems() {
    return _config.rows * _config.columns;
  }

  static bool isStarted() {
    return _started;
  }

  static void start() {
    _blockState![0] = 1;
    _currentRow = 0;
    _currentCol = _startCol;
    for(int i = 1; i < _blockState!.length; i++) {
      _blockState![i] = 0;
    }
    _started = true;
  }

  static void stop() {
    _started = false;
  }

  static void moveRow() {
    if(_currentRow < _config.rows - 1) {
      _currentRow++;
      _currentCol = _startCol;
    } else {
      onGameEnded();
    }
  }

  static void onGameEnded() {
    _started = false;
  }

  static void move() {
    int direction = _reversedMovement ? -1 : 1;
    if((_currentCol < _config.columns - 1 && !_reversedMovement) || (_reversedMovement && _currentCol > 0)) {
      if(_currentCol >= 0) {
        _blockState![_getIndex(_currentCol, _currentRow)] = 0;
      }
      _currentCol = _currentCol + direction;
      if(_currentCol >= 0) {
        _blockState![_getIndex(_currentCol, _currentRow)] = 1;
      }
    } else {
      _reversedMovement = !_reversedMovement;
      move();
    }
  }

  static int _getIndex(int column, int row) {
    return (row * _config.columns) + column;
  }
}