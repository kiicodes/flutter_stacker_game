import 'package:stacker_game/game_2d/game/filled_block_2d.dart';
import 'package:stacker_game/game_2d/static_classes/game_2d_static.dart';
import 'package:stacker_game/static_classes/common_static.dart';

class FallAnimation {
  static final List<FallAnimationItem> items = List.empty(growable: true);
  static FilledBlock2D addItem(int index) {
    final filledBlock2D = FilledBlock2D(1, Game2DStatic.vectorFromIndex(index), Game2DStatic.blockPaint);
    filledBlock2D.fallItem = FallAnimationItem(filledBlock2D: filledBlock2D, currentIndex: index, previousIndex: index);
    items.add(filledBlock2D.fallItem!);
    return filledBlock2D;
  }

  static void moveIt() {
    final List<FallAnimationItem> toRemove = List.empty(growable: true);
    for(int i = 0; i < items.length; i++) {
      final item = items[i];
      item.previousIndex = item.currentIndex;
      item.currentIndex = item.currentIndex - CommonStatic.config().columns;
      if(item.currentIndex < 0) {
        Game2DStatic.filledIndexes.add(item.previousIndex);
        toRemove.add(item);
      } else {
        if(Game2DStatic.filledIndexes.contains(item.currentIndex)) {
          Game2DStatic.filledIndexes.add(item.previousIndex);
          toRemove.add(item);
        } else {
          item.filledBlock2D.position =
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
  final FilledBlock2D filledBlock2D;
  FallAnimationItem({required this.filledBlock2D, required this.currentIndex, required this.previousIndex});
}