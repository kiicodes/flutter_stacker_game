import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_classes/game_config.dart';

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
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.0;

    for (int i = 0; i <= gameConfig.rows; i++) {
      final lineY = startY + i * blockSize;
      canvas.drawLine(Offset(startX, lineY), Offset(startX + gameWidth, lineY), paint);
    }
    for (int i = 0; i <= gameConfig.columns; i++) {
      final lineX = startX + i * blockSize;
      canvas.drawLine(Offset(lineX, startY), Offset(lineX, startY + gameHeight), paint);
    }

    /*/ Draw vertical lines
    final blockSize = GameStatic.blockSize();
    final totalX = blockSize * (GameStatic.config().columns + 1);
    final bordersXSize = screenSize.x - (totalX + blockSize);

    final totalY = blockSize * (GameStatic.config().rows + 1);
    final bordersYSize = screenSize.y - (totalY + blockSize);

    for (double x = bordersXSize; x < totalX; x += blockSize) {
      canvas.drawLine(Offset(x, bordersYSize), Offset(x, totalY), paint);
    }

    // Draw horizontal lines
    for (double y = bordersYSize; y < totalY; y += blockSize) {
      canvas.drawLine(Offset(0, y), Offset(screenSize.x, y), paint);
    }// */
  }

  @override
  void update(double dt) {
    // Add any update logic here if needed
  }
}