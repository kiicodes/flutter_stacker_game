import 'package:flutter/cupertino.dart';

class GameConfig {
  final int columns;
  final int rows;
  final int blockColumns;
  final int speed;
  static const Color bgColor = Color(0xFFECEFF1);
  static const Color borderColor = Color(0xFFD0E0E3);
  static const Color activeColor = Color(0xFFFF6E40);

  const GameConfig({Key? key, this.columns = 6, this.rows = 7, this.blockColumns = 3, this.speed = 0});
}