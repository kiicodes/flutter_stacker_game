import 'package:flutter/material.dart';
import 'package:stacker_game/game_classes/game_config.dart';
import 'package:stacker_game/static_classes/game.dart';

class EmptyBlock extends StatelessWidget {
  const EmptyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final blockSize = Game.blockSize();
    return Container(
      height: blockSize,
      width: blockSize,
      decoration: BoxDecoration(
        border: Border.all(color: GameConfig.borderColor),
        color: GameConfig.bgColor
      ),
    );
  }
}
