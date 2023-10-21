import 'dart:async';

import 'package:stacker_game/static_classes/game.dart';

class FallAnimation {
  static const _speed = 300;
  static List<_FallAnimationItem>? _items;

  static void addFallAnimation(int column, int row) {
    _items ??= List.empty(growable: true);
    _items!.add(_FallAnimationItem(column, row));
    _items!.last.start();
  }

  static void clearAll() {
    if(_items != null) {
      for(_FallAnimationItem item in _items!) {
        item.stop(false);
      }
      _items?.clear();
    }
  }
}

class _FallAnimationItem {
  Timer? timer;
  int column;
  int row;

  _FallAnimationItem(this.column, this.row);

  void start() {
    Game.changeState(column, row, 1);
    timer = Timer.periodic(const Duration(milliseconds: FallAnimation._speed), (_) {
      Game.changeState(column, row, 0);
      row--;
      if(row < 0) {
        stop(true);
      } else {
        if(Game.getState(column, row) == 1) {
          Game.changeState(column, row + 1, 1);
          stop(true);
          return;
        }
        Game.changeState(column, row, 1);
      }
    });
  }

  void stop(bool removeSelf) {
    timer?.cancel();
    timer = null;
    if(removeSelf) {
      FallAnimation._items?.remove(this);
    }
  }
}