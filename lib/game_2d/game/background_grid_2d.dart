import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/static_classes/game_2d_static.dart';
import 'package:stacker_game/shared/game_config.dart';

class BackgroundGrid2D extends Component {
  final Vector2 screenSize;
  final double blockSize;
  final GameConfig gameConfig;
  final double startX;
  final double startY;
  final double gameWidth;
  final double gameHeight;

  BackgroundGrid2D(this.screenSize, this.blockSize, this.gameConfig, this.startX, this.startY, this.gameWidth, this.gameHeight);

  @override
  void render(Canvas canvas) {
    final backgroundPaint = Paint()
      ..color = Colors.white;
    final Rect bgBounds = Rect.fromLTRB(0, 0, screenSize.x, screenSize.y,);
    canvas.drawRect(bgBounds, backgroundPaint);
    final gameBackgroundPaint = Paint()
      ..color = GameConfig.bgColor;
    final Rect bgGameBounds = Rect.fromLTRB(startX, startY, startX + Game2DStatic.gameWidth, startY + Game2DStatic.gameHeight,);
    canvas.drawRect(bgGameBounds, gameBackgroundPaint);
    final paint = Paint()
      ..color = GameConfig.borderColor
      ..strokeWidth = 1.0;

    for (int i = 0; i <= gameConfig.rows; i++) {
      final lineY = startY + i * blockSize;
      canvas.drawLine(Offset(startX, lineY), Offset(startX + gameWidth, lineY), paint);
    }
    for (int i = 0; i <= gameConfig.columns; i++) {
      final lineX = startX + i * blockSize;
      canvas.drawLine(Offset(lineX, startY), Offset(lineX, startY + gameHeight), paint);
    }
  }
}