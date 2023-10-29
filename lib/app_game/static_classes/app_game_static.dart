import 'dart:async';

import 'package:stacker_game/app_game/static_classes/fall_animation.dart';
import 'package:stacker_game/static_classes/common_static.dart';

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
    return CommonStatic.config().rows * CommonStatic.config().columns;
  }

  static double gameHeight() {
    return CommonStatic.config().rows * CommonStatic.blockSize();
  }

  static double gameWidth() {
    return CommonStatic.config().columns * CommonStatic.blockSize();
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
    CommonStatic.reset();
    FallAnimation.clearAll();
    _expectedColumns = null;
    _activeColumns = null;
    _refreshCallback = null;
    _timer?.cancel();
    _timer = null;
    _blockState![0] = 1;
    for(int i = 1; i < _blockState!.length; i++) {
      _blockState![i] = 0;
    }
  }

  static void start(Function() refreshCallback, Function() onWin, Function() onLose) {
    reset();
    CommonStatic.start();
    _expectedColumns = List.empty(growable: true);
    _activeColumns = List.empty(growable: true);
    _refreshCallback = refreshCallback;
    _onWin = onWin;
    _onLose = onLose;
    _startTimer();
  }

  static void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: CommonStatic.calculatedLevelSpeed()), (timer) {
      GameStatic.move();
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
    });
  }

  static void stop() {
    CommonStatic.stop();
    FallAnimation.clearAll();
    _timer?.cancel();
    _onWin = null;
    _onLose = null;
  }

  static void nextLevel() {
    final lostColumns = _activeColumns!.where((element) => !_expectedColumns!.contains(element)).toList();
    if(lostColumns.isNotEmpty) {
      for(int i = 0; i < lostColumns.length; i++) {
        _blockState![_getIndex(lostColumns[i], CommonStatic.currentRow)] = 0;
        FallAnimation.addFallAnimation(lostColumns[i], CommonStatic.currentRow);
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
      CommonStatic.currentBlockColumns = _activeColumns!.length;
      _expectedColumns!.clear();
      _expectedColumns!.addAll(_activeColumns!);
    }
    _timer?.cancel();
    CommonStatic.level++;
    if(CommonStatic.currentRow < CommonStatic.config().rows - 1) {
      CommonStatic.currentRow++;
      CommonStatic.currentCol = CommonStatic.startCol;
      _startTimer();
    } else {
      gameOver(true);
    }
  }

  static void gameOver(bool won) {
    _timer?.cancel();
    _timer = null;
    CommonStatic.gameOver(won);
    if(won && _onWin != null) {
      _onWin!();
    } else if(!won && _onLose != null) {
      _onLose!();
    }
  }

  static void move() {
    int direction = CommonStatic.reversedMovement ? -1 : 1;
    if((CommonStatic.currentCol < CommonStatic.config().columns + CommonStatic.currentBlockColumns - 2 && !CommonStatic.reversedMovement) || (CommonStatic.reversedMovement && CommonStatic.currentCol > 0)) {
      CommonStatic.currentCol = CommonStatic.currentCol + direction;

      _activeColumns!.clear();

      for(int i = 0; i < CommonStatic.currentBlockColumns; i++) {
        if(CommonStatic.currentCol - i > -1 && CommonStatic.currentCol - i < CommonStatic.config().columns) {
          _activeColumns!.add(CommonStatic.currentCol - i);
        }
      }

      if(CommonStatic.currentRow == 0) {
        _expectedColumns!.clear();
        _expectedColumns!.addAll(_activeColumns!);
      }

      for(int i = 0; i < CommonStatic.config().columns; i++) {
        if(_activeColumns!.contains(i)) {
          _blockState![_getIndex(i, CommonStatic.currentRow)] = 1;
        } else {
          _blockState![_getIndex(i, CommonStatic.currentRow)] = 0;
        }
      }
    } else {
      CommonStatic.reversedMovement = !CommonStatic.reversedMovement;
      move();
    }
  }

  static int _getIndex(int column, int row) {
    return (row * CommonStatic.config().columns) + column;
  }
}