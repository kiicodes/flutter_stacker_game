import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/filled_block_2d.dart';
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
      add(FilledBlock2D(activeBlock!.quantity, Game2DStatic.vectorFromIndex(Game2DStatic.activeIndex), Game2DStatic.blockPaint));
      Game2DStatic.changeRow(activeBlock!.quantity);
    }
  }
}

