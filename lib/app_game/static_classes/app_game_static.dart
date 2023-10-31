import 'dart:async';

import 'package:stacker_game/app_game/static_classes/fall_animation.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class GameStatic {
  static List<int>? _squareState;
  static List<int>? _expectedColumns;
  static List<int>? _activeColumns;
  static Timer? _timer;
  static Function()? _refreshCallback;
  static Function()? _onWin;
  static Function()? _onLose;

  static List<int> items() {
    if(_squareState == null) {
      _squareState = List.empty(growable: true);
      for(int i = 0; i < countItems(); i++) {
        _squareState!.add(0);
      }
    }
    return _squareState!;
  }

  static int countItems() {
    return SharedData.config.rows * SharedData.config.columns;
  }

  static double gameHeight() {
    return SharedData.config.rows * GameConfig.squareSize;
  }

  static double gameWidth() {
    return SharedData.config.columns * GameConfig.squareSize;
  }

  static int getState(int column, int row) {
    if(_squareState == null) {
      return 0;
    }
    return _squareState![_getIndex(column, row)] ;
  }

  static void changeState(int column, int row, int newState) {
    if(_squareState == null) {
      return;
    }
    _squareState![_getIndex(column, row)] = newState;
    if(_refreshCallback != null) {
      _refreshCallback!();
    }
  }

  static void reset() {
    SharedData.reset();
    _squareState = null;
    //CommonStatic.initValues();
    FallAnimation.clearAll();
    _expectedColumns = null;
    _activeColumns = null;
    _refreshCallback = null;
    _timer?.cancel();
    _timer = null;
    items()[0] = 1;
    for(int i = 1; i < _squareState!.length; i++) {
      _squareState![i] = 0;
    }
  }

  static void start(Function() refreshCallback, Function() onWin, Function() onLose) {
    reset();
    SharedData.start();
    _expectedColumns = List.empty(growable: true);
    _activeColumns = List.empty(growable: true);
    _refreshCallback = refreshCallback;
    _onWin = onWin;
    _onLose = onLose;
    _startTimer();
  }

  static void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: SharedData.calculateLevelSpeed()), (timer) {
      GameStatic.move();
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
    });
  }

  static void stop() {
    SharedData.stop();
    FallAnimation.clearAll();
    _timer?.cancel();
    _onWin = null;
    _onLose = null;
  }

  static void nextLevel() {
    final lostColumns = _activeColumns!.where((element) => !_expectedColumns!.contains(element)).toList();
    if(lostColumns.isNotEmpty) {
      for(int i = 0; i < lostColumns.length; i++) {
        _squareState![_getIndex(lostColumns[i], SharedData.currentRow)] = 0;
        FallAnimation.addFallAnimation(lostColumns[i], SharedData.currentRow);
      }
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
    }
    _activeColumns = _activeColumns!.where((element) => _expectedColumns!.contains(element)).toList();
    if(_activeColumns!.isEmpty) {
      gameOver(false);
      return;
    } else {
      SharedData.currentSquareQuantity = _activeColumns!.length;
      _expectedColumns!.clear();
      _expectedColumns!.addAll(_activeColumns!);
    }
    _timer?.cancel();
    if(SharedData.currentRow < SharedData.config.rows - 1) {
      SharedData.currentRow++;
      SharedData.currentCol = SharedData.startCol;
      _startTimer();
    } else {
      gameOver(true);
    }
  }

  static void gameOver(bool won) {
    _timer?.cancel();
    _timer = null;
    SharedData.gameOver();
    if(won && _onWin != null) {
      _onWin!();
    } else if(!won && _onLose != null) {
      _onLose!();
    }
  }

  static void move() {
    int direction = SharedData.reversedMovement ? -1 : 1;
    if((SharedData.currentCol < SharedData.config.columns + SharedData.currentSquareQuantity - 2 && !SharedData.reversedMovement) || (SharedData.reversedMovement && SharedData.currentCol > 0)) {
      SharedData.currentCol = SharedData.currentCol + direction;

      _activeColumns!.clear();

      for(int i = 0; i < SharedData.currentSquareQuantity; i++) {
        if(SharedData.currentCol - i > -1 && SharedData.currentCol - i < SharedData.config.columns) {
          _activeColumns!.add(SharedData.currentCol - i);
        }
      }

      if(SharedData.currentRow == 0) {
        _expectedColumns!.clear();
        _expectedColumns!.addAll(_activeColumns!);
      }

      for(int i = 0; i < SharedData.config.columns; i++) {
        if(_activeColumns!.contains(i)) {
          _squareState![_getIndex(i, SharedData.currentRow)] = 1;
        } else {
          _squareState![_getIndex(i, SharedData.currentRow)] = 0;
        }
      }
    } else {
      SharedData.reversedMovement = !SharedData.reversedMovement;
      move();
    }
  }

  static int _getIndex(int column, int row) {
    return (row * SharedData.config.columns) + column;
  }
}