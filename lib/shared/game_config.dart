import 'package:flutter/cupertino.dart';
import 'package:stacker_game/shared/game_levels.dart';

class GameConfig {
  final String name;
  final int columns;
  final int rows;
  final int squareQuantity;
  final int startMs;
  final int lastMs;
  int _myIndex = -1;
  static const Color bgColor = Color(0xFFECEFF1);
  static const Color borderColor = Color(0xFFD0E0E3);
  static const Color activeColor = Color(0xFFFF6E40);
  static late double squareSize;
  static const double margin = 20;

  String getLevelKey() {
    return "$startMs|$lastMs|$columns|$rows|$squareQuantity";
  }

  int levelIndex() {
    if(_myIndex == -1) {
      for(int i = 0; i < GameLevels.levels.length; i++) {
        if(name == GameLevels.levels[i].name) {
          _myIndex = i;
          break;
        }
      }
    }
    return _myIndex;
  }

  GameConfig({Key? key, required this.name, required this.columns, required this.rows, required this.squareQuantity, required this.startMs, required this.lastMs});
}