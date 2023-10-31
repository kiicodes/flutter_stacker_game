import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';

class FilledSquare extends StatelessWidget {
  const FilledSquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GameConfig.squareSize,
      width: GameConfig.squareSize,
      color: GameConfig.activeColor,
    );
  }
}
