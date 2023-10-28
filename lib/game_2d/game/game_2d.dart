import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/filled_block_2d.dart';
import 'package:stacker_game/game_classes/game_config.dart';

import 'package:stacker_game/static_classes/common_static.dart';

class Game2D extends FlameGame with TapCallbacks {
  late double blockSize;
  late double gameWidth;
  late double startX;
  late double gameHeight;
  late double startY;
  late GameConfig gameConfig;

  static List _getPositionFromIndex(int index, int columns) {
    final int column = index % columns;
    final int row = index ~/ columns;
    return [column, row];
  }

  @override
  Future<void> onLoad() async {
    initValues();
    add(BackgroundGrid2D(size, blockSize, gameConfig, startX, startY, gameWidth, gameHeight));
    addBlock2D(1);
  }

  void initValues() {
    CommonStatic.configure(size.x, size.y);

    blockSize = CommonStatic.blockSize();
    gameConfig = CommonStatic.config();

    gameWidth = blockSize * gameConfig.columns;
    final remainingWidth = size.x - gameWidth;
    startX = (remainingWidth / 2 + CommonStatic.marginSize() / 2) / 2;

    gameHeight = blockSize * gameConfig.rows;
    final remainingHeight = size.y - gameHeight;
    startY = (remainingHeight / 2 + CommonStatic.marginSize() / 2);
  }

  void addBlock2D(int index) {
    final reversedIndex = (gameConfig.columns * gameConfig.rows - 1) - index;
    final xy = _getPositionFromIndex(reversedIndex, gameConfig.columns);
    final int x = xy[0];
    final int y = xy[1];
    add(FilledBlock2D(2, Vector2(startX + x * blockSize, startY + y * blockSize)));
  }

  /*@override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      add(Square(touchPoint));
    }
  }*/
}

/*class Square extends RectangleComponent with TapCallbacks {
  static const speed = 3;
  static const squareSize = 128.0;
  static const indicatorSize = 6.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();

  Square(Vector2 position)
      : super(
    position: position,
    size: Vector2.all(squareSize),
    anchor: Anchor.center,
  );

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      RectangleComponent(
        size: Vector2.all(indicatorSize),
        paint: blue,
      ),
    );
    add(
      RectangleComponent(
        position: size / 2,
        size: Vector2.all(indicatorSize),
        anchor: Anchor.center,
        paint: red,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    event.handled = true;
  }
}*/

