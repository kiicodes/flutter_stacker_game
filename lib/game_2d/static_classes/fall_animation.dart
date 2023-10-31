import 'package:stacker_game/game_2d/game/filled_square_2d.dart';
import 'package:stacker_game/game_2d/game/game_2d.dart';
import 'package:stacker_game/game_2d/static_classes/game_2d_static.dart';
import 'package:stacker_game/shared/shared_data.dart';

class FallAnimation {
  static final List<FallAnimationItem> items = List.empty(growable: true);
  static FilledSquare2D addItem(int index) {
    final filledSquare2D = FilledSquare2D(1, Game2DStatic.vectorFromIndex(index), Game2DStatic.squarePaint);
    Game2D.removeToNewGame.add(filledSquare2D);
    filledSquare2D.fallItem = FallAnimationItem(filledSquare2D: filledSquare2D, currentIndex: index, previousIndex: index);
    items.add(filledSquare2D.fallItem!);
    return filledSquare2D;
  }

  static void moveIt() {
    final List<FallAnimationItem> toRemove = List.empty(growable: true);
    for(int i = 0; i < items.length; i++) {
      final item = items[i];
      item.previousIndex = item.currentIndex;
      item.currentIndex = item.currentIndex - SharedData.config.columns;
      if(item.currentIndex < 0) {
        Game2DStatic.filledIndexes.add(item.previousIndex);
        toRemove.add(item);
      } else {
        if(Game2DStatic.filledIndexes.contains(item.currentIndex)) {
          Game2DStatic.filledIndexes.add(item.previousIndex);
          toRemove.add(item);
        } else {
          item.filledSquare2D.position =
              Game2DStatic.vectorFromIndex(item.currentIndex);
        }
      }
    }
    for(int i = 0; i < toRemove.length; i++) {
      items.remove(toRemove[i]);
    }
  }
}

class FallAnimationItem {
  int currentIndex;
  int previousIndex;
  final FilledSquare2D filledSquare2D;
  FallAnimationItem({required this.filledSquare2D, required this.currentIndex, required this.previousIndex});
}