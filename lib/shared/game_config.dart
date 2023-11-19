import 'package:flutter/cupertino.dart';

class GameConfig {
  final int columns;
  final int rows;
  final int squareQuantity;
  final int startMs;
  final int lastMs;
  static const Color bgColor = Color(0xFFECEFF1);
  static const Color borderColor = Color(0xFFD0E0E3);
  static const Color activeColor = Color(0xFFFF6E40);
  static late double squareSize;
  static const double margin = 20;

  const GameConfig({Key? key, required this.columns, required this.rows, required this.squareQuantity, required this.startMs, required this.lastMs});
}