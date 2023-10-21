import 'package:flutter/cupertino.dart';

class GameConfig {
  final int columns;
  final int rows;
  final int blockColumns;
  final double speed;

  const GameConfig({Key? key, this.columns = 6, this.rows = 7, this.blockColumns = 3, this.speed = 3});
}