import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/levels/game_levels.dart';

class GameConfig {
  final String name;
  final int columns;
  final int rows;
  final int squareQuantity;
  final int startMs;
  final int lastMs;
  final int twoStarsPoints;
  final int threeStarsPoints;
  int _myIndex = -1;
  int currentStars = 0;
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

  GameConfig({Key? key, required this.name, required this.columns, required this.rows,
    required this.squareQuantity, required this.startMs, required this.lastMs,
    required this.twoStarsPoints, required this.threeStarsPoints
  });
}