import 'package:stacker_game/game_classes/game_config.dart';
import 'dart:async';

class Game {
  static final _levelSpeeds = [500, 450, 300, 250, 200, 150, 100, 100, 100, 100, 100];
  static const _startCol = 0;
  static const GameConfig _config = GameConfig();
  static List<int>? _blockState;
  static List<int>? _expectedColumns;
  static List<int>? _activeColumns;
  static int _currentBlockColumns = 0;
  static int _currentRow = 0;
  static int _currentCol = _startCol;
  static double _availableHeight = 0;
  static double _availableWidth = 0;
  static bool _started = false;
  static bool _reversedMovement = false;
  static int _level = 1;
  static Timer? _timer;
  static Function()? _refreshCallback;

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

  static void reset() {
    _expectedColumns = null;
    _activeColumns = null;
    _refreshCallback = null;
    _timer?.cancel();
    _timer = null;
    _blockState![0] = 1;
    _currentRow = 0;
    _currentCol = _startCol;
    _currentBlockColumns = _config.blockColumns;
    _level = 1;
    for(int i = 1; i < _blockState!.length; i++) {
      _blockState![i] = 0;
    }
  }

  static void start(Function() refreshCallback) {
    reset();
    _started = true;
    _refreshCallback = refreshCallback;
    _startTimer();
  }

  static void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: _levelSpeeds[_level - 1]), (timer) {
      Game.move();
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
    });
  }

  static void stop() {
    _started = false;
  }

  static void nextLevel() {
    final lostColumns = _activeColumns!.where((element) => !_expectedColumns!.contains(element)).toList();
    if(lostColumns.isNotEmpty) {
      for(int i = 0; i < lostColumns.length; i++) {
        _blockState![_getIndex(lostColumns[i], _currentRow)] = 0;
      }
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
    }
    _activeColumns = _activeColumns!.where((element) => _expectedColumns!.contains(element)).toList();
    if(_activeColumns!.isEmpty) {
      gameOver();
      return;
    } else {
      _currentBlockColumns = _activeColumns!.length;
      _expectedColumns = List.empty(growable: true);
      _expectedColumns!.addAll(_activeColumns!);
    }
    _timer?.cancel();
    _level++;
    if(_currentRow < _config.rows - 1) {
      _currentRow++;
      _currentCol = _startCol;
      _startTimer();
    } else {
      onGameEnded();
    }
  }

  static void onGameEnded() {
    _started = false;
  }

  static void gameOver() {
    stop();
    reset();
  }

  static void move() {
    int direction = _reversedMovement ? -1 : 1;
    if((_currentCol < _config.columns + _currentBlockColumns - 2 && !_reversedMovement) || (_reversedMovement && _currentCol > 0)) {
      _currentCol = _currentCol + direction;

      if(_activeColumns == null) {
        _activeColumns = List.empty(growable: true);
      } else {
        _activeColumns!.clear();
      }

      for(int i = 0; i < _currentBlockColumns; i++) {
        if(_currentCol - i > -1 && _currentCol - i < _config.columns) {
          _activeColumns!.add(_currentCol - i);
        }
      }

      if(_currentRow == 0) {
        _expectedColumns = List.empty(growable: true);
        _expectedColumns!.addAll(_activeColumns!);
      }

      for(int i = 0; i < _config.columns; i++) {
        if(_activeColumns!.contains(i)) {
          _blockState![_getIndex(i, _currentRow)] = 1;
        } else {
          _blockState![_getIndex(i, _currentRow)] = 0;
        }
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