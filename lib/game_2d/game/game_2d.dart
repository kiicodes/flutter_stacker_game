import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/filled_block_2d.dart';
import 'package:stacker_game/game_2d/static_classes/fall_animation.dart';
import 'package:stacker_game/game_2d/static_classes/game_2d_static.dart';
import 'package:stacker_game/static_classes/common_static.dart';

class Game2D extends FlameGame with TapCallbacks {
  FilledBlock2D? activeBlock;
  List<FilledBlock2D> fixedBlocks = List.empty(growable: true);
  double myDt = 0;

  @override
  Future<void> onLoad() async {
    Game2DStatic.initValues(size);
    add(
      BackgroundGrid2D(
        size,
        Game2DStatic.blockSize,
        Game2DStatic.gameConfig,
        Game2DStatic.startX,
        Game2DStatic.startY,
        Game2DStatic.gameWidth,
        Game2DStatic.gameHeight
      )
    );
    addBlock2D(0);
  }

  void addBlock2D(int index) {
    activeBlock = FilledBlock2D(CommonStatic.currentBlockColumns, Game2DStatic.vectorFromIndex(Game2DStatic.activeIndex), Game2DStatic.blockPaint);
    add(activeBlock!);
  }

  @override
  void update(double dt) {
    if(CommonStatic.started) {
      myDt = myDt + dt;
      if (myDt > Game2DStatic.currentSpeed / 1000.0) {
        FallAnimation.moveIt();
        Game2DStatic.move();
        if (activeBlock != null) {
          int newIndex = Game2DStatic.activeIndex;
          if(newIndex > Game2DStatic.rowEndIndex) {
            final diff = Game2DStatic.rowEndIndex - newIndex;
            activeBlock!.changeSize(CommonStatic.currentBlockColumns + diff);
            newIndex = Game2DStatic.rowEndIndex;
          } else if(newIndex - CommonStatic.currentBlockColumns + 1 < Game2DStatic.rowStartIndex) {
            final newSize = newIndex + 1 - Game2DStatic.rowStartIndex;
            activeBlock!.changeSize(newSize);
          } else {
            activeBlock!.changeSize(CommonStatic.currentBlockColumns);
          }
          activeBlock!.blockIndex = newIndex;
          /*Game2DStatic.activeIndex++;
          if (Game2DStatic.activeIndex == Game2DStatic.maxIndex) {
            Game2DStatic.activeIndex = 0;
          }*/
          activeBlock!.position = Game2DStatic.vectorFromIndex(newIndex);
        }
        myDt = 0;
      }
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!CommonStatic.started) {
      Game2DStatic.start();
    } else {
      final List<int> hitIndexes = List.empty(growable: true);
      if(Game2DStatic.expectedIndexes.isNotEmpty) {
        for(int i = 0; i < activeBlock!.quantity; i++) {
          if(Game2DStatic.expectedIndexes.contains(activeBlock!.blockIndex - i)) {
            hitIndexes.add(activeBlock!.blockIndex - i);
          } else {
            add(FallAnimation.addItem(activeBlock!.blockIndex - i));
          }
        }
        if(hitIndexes.isNotEmpty) {
          add(FilledBlock2D(
              hitIndexes.length, Game2DStatic.vectorFromIndex(hitIndexes.first),
              Game2DStatic.blockPaint));
          CommonStatic.currentBlockColumns = hitIndexes.length;
        }
      } else {
        for(int i = 0; i < activeBlock!.quantity; i++) {
          hitIndexes.add(activeBlock!.blockIndex - i);
        }
        add(FilledBlock2D(activeBlock!.quantity, Game2DStatic.vectorFromIndex(Game2DStatic.activeIndex), Game2DStatic.blockPaint));
      }
      Game2DStatic.filledIndexes.addAll(hitIndexes);
      Game2DStatic.changeRow(activeBlock!.quantity, hitIndexes);
    }
  }
}

