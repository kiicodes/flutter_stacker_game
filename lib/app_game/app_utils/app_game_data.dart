import 'dart:async';
import 'package:stacker_game/app_game/app_utils/fall_animation.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class AppGameData {
  static List<bool> squareState = List.empty(growable: true);
  static List<int> _expectedColumns = List.empty(growable: true);
  static List<int> _activeColumns = List.empty(growable: true);
  static Timer? _timer;
  static Function()? _refreshCallback;
  static Function()? _onWin;
  static Function()? _onLose;

  static void initItems() {
    for(int i = 0; i < countItems(); i++) {
      squareState.add(false);
    }
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

  static bool getState(int column, int row) {
    return squareState[_getIndex(column, row)] ;
  }

  static void changeState(int column, int row, bool newState) {
    squareState[_getIndex(column, row)] = newState;
    if(_refreshCallback != null) {
      _refreshCallback!();
    }
  }

  static void reset() {
    SharedData.reset();
    squareState.clear();
    FallAnimation.clearAll();
    _expectedColumns.clear();
    _refreshCallback = null;
    _timer?.cancel();
    _timer = null;
    SharedData.currentCol = SharedData.startCol;
    initItems();
  }

  static void start(Function() refreshCallback, Function() onWin, Function() onLose) {
    reset();
    _setStartPosition();
    _refreshCallback = refreshCallback;
    _onWin = onWin;
    _onLose = onLose;
    SharedData.start();
    _startTimer();
  }

  static void _setStartPosition() {
    squareState[0] = true;
    _activeColumns.clear();
    _activeColumns.add(0);
    SharedData.currentSquareQuantity = _activeColumns.length;
    _expectedColumns.addAll(_activeColumns);
  }

  static void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: SharedData.calculateLevelSpeed()), (timer) {
      AppGameData.move();
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
    if(_activeColumns.isEmpty) {
      return;
    }
    final lostColumns = _activeColumns.where((element) => !_expectedColumns.contains(element)).toList();
    if(lostColumns.isNotEmpty) {
      for(int i = 0; i < lostColumns.length; i++) {
        squareState[_getIndex(lostColumns[i], SharedData.currentRow)] = false;
        FallAnimation.addFallAnimation(lostColumns[i], SharedData.currentRow);
      }
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
    }
    _activeColumns = _activeColumns.where((element) => _expectedColumns.contains(element)).toList(growable: true);
    if(_activeColumns.isEmpty && SharedData.currentRow > 0) {
      gameOver(false);
      return;
    } else {
      SharedData.currentSquareQuantity = _activeColumns.length;
      _expectedColumns.clear();
      _expectedColumns.addAll(_activeColumns);
    }
    _timer?.cancel();
    if(SharedData.currentRow < SharedData.config.rows - 1) {
      SharedData.currentRow++;
      SharedData.currentCol = SharedData.startCol;
      // Set position in next row
      squareState[SharedData.startCol + (SharedData.currentRow * SharedData.config.columns)] = true;
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
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
    final int maxColumnPosition = SharedData.config.columns + SharedData.currentSquareQuantity - 2;
    const int minColumnPosition = 0;
    final bool shouldReturnFromEnd = (SharedData.currentCol == maxColumnPosition && !SharedData.reversedMovement);
    final bool shouldAdvanceFromStart = (SharedData.reversedMovement && SharedData.currentCol == minColumnPosition);

    print(SharedData.currentCol);
    if(shouldReturnFromEnd || shouldAdvanceFromStart) {
      SharedData.reversedMovement = !SharedData.reversedMovement;
    }
    final int direction = SharedData.reversedMovement ? -1 : 1;

    SharedData.currentCol = SharedData.currentCol + direction;

    _activeColumns.clear();

    for(int i = 0; i < SharedData.currentSquareQuantity; i++) {
      if(SharedData.currentCol - i > -1 && SharedData.currentCol - i < SharedData.config.columns) {
        _activeColumns.add(SharedData.currentCol - i);
      }
    }

    if(SharedData.currentRow == 0) {
      _expectedColumns.clear();
      _expectedColumns.addAll(_activeColumns);
    }

    for(int i = 0; i < SharedData.config.columns; i++) {
      if(_activeColumns.contains(i)) {
        squareState[_getIndex(i, SharedData.currentRow)] = true;
      } else {
        squareState[_getIndex(i, SharedData.currentRow)] = false;
      }
    }
  }

  static int _getIndex(int column, int row) {
    return (row * SharedData.config.columns) + column;
  }
}