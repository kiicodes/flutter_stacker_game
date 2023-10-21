import 'package:flutter/cupertino.dart';

class GameConfig {
  final int columns;
  final int rows;
  final int blockColumns;
  final double speed;

  const GameConfig({Key? key, required this.columns, required this.rows, required this.blockColumns, required this.speed});
}