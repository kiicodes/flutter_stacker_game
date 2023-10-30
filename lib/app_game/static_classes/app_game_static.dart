import 'dart:async';

import 'package:stacker_game/app_game/static_classes/fall_animation.dart';
import 'package:stacker_game/shared/shared_data.dart';

class GameStatic {
  static List<int>? _blockState;
  static List<int>? _expectedColumns;
  static List<int>? _activeColumns;
  static Timer? _timer;
  static Function()? _refreshCallback;
  static Function()? _onWin;
  static Function()? _onLose;

  static List<int> items() {
    if(_blockState == null) {
      _blockState = List.empty(growable: true);
      for(int i = 0; i < countItems(); i++) {
        _blockState!.add(0);
      }
    }
    return _blockState!;
  }

  static int countItems() {
    return SharedData.config.rows * SharedData.config.columns;
  }

  static double gameHeight() {
    return SharedData.config.rows * SharedData.blockSize();
  }

  static double gameWidth() {
    return SharedData.config.columns * SharedData.blockSize();
  }

  static int getState(int column, int row) {
    if(_blockState == null) {
      return 0;
    }
    return _blockState![_getIndex(column, row)] ;
  }

  static void changeState(int column, int row, int newState) {
    if(_blockState == null) {
      return;
    }
    _blockState![_getIndex(column, row)] = newState;
    if(_refreshCallback != null) {
      _refreshCallback!();
    }
  }

  static void reset() {
    SharedData.reset();
    _blockState = null;
    //CommonStatic.initValues();
    FallAnimation.clearAll();
    _expectedColumns = null;
    _activeColumns = null;
    _refreshCallback = null;
    _timer?.cancel();
    _timer = null;
    items()[0] = 1;
    for(int i = 1; i < _blockState!.length; i++) {
      _blockState![i] = 0;
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
    _timer = Timer.periodic(Duration(milliseconds: SharedData.calculatedLevelSpeed()), (timer) {
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
        _blockState![_getIndex(lostColumns[i], SharedData.currentRow)] = 0;
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
      SharedData.currentBlockColumns = _activeColumns!.length;
      _expectedColumns!.clear();
      _expectedColumns!.addAll(_activeColumns!);
    }
    _timer?.cancel();
    SharedData.level++;
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
    SharedData.gameOver(won);
    if(won && _onWin != null) {
      _onWin!();
    } else if(!won && _onLose != null) {
      _onLose!();
    }
  }

  static void move() {
    int direction = SharedData.reversedMovement ? -1 : 1;
    if((SharedData.currentCol < SharedData.config.columns + SharedData.currentBlockColumns - 2 && !SharedData.reversedMovement) || (SharedData.reversedMovement && SharedData.currentCol > 0)) {
      SharedData.currentCol = SharedData.currentCol + direction;

      _activeColumns!.clear();

      for(int i = 0; i < SharedData.currentBlockColumns; i++) {
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
          _blockState![_getIndex(i, SharedData.currentRow)] = 1;
        } else {
          _blockState![_getIndex(i, SharedData.currentRow)] = 0;
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