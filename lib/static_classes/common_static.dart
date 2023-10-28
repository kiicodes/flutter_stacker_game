import 'package:stacker_game/game_classes/game_config.dart';
import 'dart:async';

import 'package:stacker_game/app_game/static_classes/fall_animation.dart';

class CommonStatic {
  static GameConfig _config = const GameConfig();
  static double _availableHeight = 0;
  static double _availableWidth = 0;
  static const double _margin = 20;

  static void configure(double availableWidth, double availableHeight) {
    _availableHeight = availableHeight - _margin;
    _availableWidth = availableWidth - _margin;
  }

  static GameConfig config() {
    return _config;
  }

  static void setConfig(GameConfig newConfig) {
    _config = newConfig;
  }

  static double blockSize() {
    final byWidth = _availableWidth / _config.columns;
    final byHeight = _availableHeight / _config.rows;

    return byHeight > byWidth ? byWidth : byHeight;
  }

  static double marginSize() {
    return _margin;
  }
}