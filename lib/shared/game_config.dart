import 'package:flutter/cupertino.dart';

class GameConfig {
  final int columns;
  final int rows;
  final int squareQuantity;
  final int level;
  static const Color bgColor = Color(0xFFECEFF1);
  static const Color borderColor = Color(0xFFD0E0E3);
  static const Color activeColor = Color(0xFFFF6E40);

  static final levelSpeeds = [
    [600, 300],
    [500, 200],
    [350, 80]
  ];
  static late double squareSize;
  static const double margin = 20;

  const GameConfig({Key? key, this.columns = 6, this.rows = 7, this.squareQuantity = 3, this.level = 0});
}