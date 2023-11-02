import 'dart:async';
import 'package:stacker_game/app_game/app_utils/fall_animation.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class AppGameData {
  static final List<bool> squareState = List.empty(growable: true);
  static final List<int> _expectedColumns = List.empty(growable: true);
  static List<int> _activeColumns = List.empty(growable: true);
  static Timer? _timer;
  static Function()? _refreshCallback;
  static Function()? _onWin;
  static Function()? _onLose;
  static const int minColumnPosition = 0;
  static late int currentCol;
  static const startCol = 0;

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
    currentCol = startCol;
    squareState.clear();
    FallAnimation.clearAll();
    _expectedColumns.clear();
    _refreshCallback = null;
    _timer?.cancel();
    _timer = null;
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

  static int maxColumnPosition() {
    return SharedData.config.columns + SharedData.currentSquareQuantity - 2;
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

  static void _addFallAnimationIfNeeded() {
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
  }

  static void nextLevel() {
    _addFallAnimationIfNeeded();

    // Verify if some activeColumn matches with expectedColumns
    _activeColumns = _activeColumns.where((element) => _expectedColumns.contains(element)).toList(growable: true);
    if(_activeColumns.isEmpty && SharedData.currentRow > 0) {
      gameOver(false);
      return;
    } else {
      SharedData.currentSquareQuantity = _activeColumns.length;
      _expectedColumns.clear();
      _expectedColumns.addAll(_activeColumns);
    }

    // should create another timer with the speed increased
    _timer?.cancel();
    final isNotTheLastRow = SharedData.currentRow < SharedData.config.rows - 1;
    if(isNotTheLastRow) {
      SharedData.currentRow++;
      placeInReversedSide();
      if(_refreshCallback != null) {
        _refreshCallback!();
      }
      _startTimer();
    } else {
      gameOver(true);
    }
  }

  static void placeInReversedSide() {
    bool someSquareAtStart = currentCol == startCol || currentCol - SharedData.currentSquareQuantity < startCol;
    if(!someSquareAtStart) {
      currentCol = startCol;
    } else {
      currentCol = maxColumnPosition();
    }

    _activeColumns.clear();
    for(int i = 0; i < SharedData.currentSquareQuantity; i++) {
      if(currentCol - i > -1 && currentCol - i < SharedData.config.columns) {
        _activeColumns.add(currentCol - i);
        squareState[_getIndex(currentCol - i, SharedData.currentRow)] = true;
      }
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
    final bool shouldReturnFromEnd = (currentCol == maxColumnPosition() && !SharedData.reversedMovement);
    final bool shouldAdvanceFromStart = (SharedData.reversedMovement && currentCol == minColumnPosition);

    if(shouldReturnFromEnd || shouldAdvanceFromStart) {
      SharedData.reversedMovement = !SharedData.reversedMovement;
    }
    final int direction = SharedData.reversedMovement ? -1 : 1;
    currentCol = currentCol + direction;

    _activeColumns.clear();
    for(int i = 0; i < SharedData.currentSquareQuantity; i++) {
      if(currentCol - i > -1 && currentCol - i < SharedData.config.columns) {
        _activeColumns.add(currentCol - i);
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