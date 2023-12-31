import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/utils/game_2d_data.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class BackgroundGrid2D extends Component {
  final Vector2 screenSize;

  BackgroundGrid2D(this.screenSize);

  @override
  void render(Canvas canvas) {
    final startX = Game2DData.startX;
    final startY = Game2DData.startY;

    final backgroundPaint = Paint()
      ..color = Colors.white;
    final Rect bgBounds = Rect.fromLTRB(0, 0, screenSize.x, screenSize.y,);
    canvas.drawRect(bgBounds, backgroundPaint);
    final gameBackgroundPaint = Paint()
      ..color = GameConfig.bgColor;
    final Rect bgGameBounds = Rect.fromLTRB(startX, startY, startX + Game2DData.gameWidth, startY + Game2DData.gameHeight,);
    canvas.drawRect(bgGameBounds, gameBackgroundPaint);
    final paint = Paint()
      ..color = GameConfig.borderColor
      ..strokeWidth = 1.0;

    for (int i = 0; i <= SharedData.config.rows; i++) {
      final lineY = startY + i * GameConfig.squareSize;
      canvas.drawLine(Offset(startX, lineY), Offset(startX + Game2DData.gameWidth, lineY), paint);
    }
    for (int i = 0; i <= SharedData.config.columns; i++) {
      final lineX = startX + i * GameConfig.squareSize;
      canvas.drawLine(Offset(lineX, startY), Offset(lineX, startY + Game2DData.gameHeight), paint);
    }
  }
}