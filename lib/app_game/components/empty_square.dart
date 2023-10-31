import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';

class EmptySquare extends StatelessWidget {
  const EmptySquare({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GameConfig.squareSize,
      width: GameConfig.squareSize,
      decoration: BoxDecoration(
        border: Border.all(color: GameConfig.borderColor),
        color: GameConfig.bgColor
      ),
    );
  }
}
