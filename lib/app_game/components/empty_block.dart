import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class EmptyBlock extends StatelessWidget {
  const EmptyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: GameConfig.blockSize,
      width: GameConfig.blockSize,
      decoration: BoxDecoration(
        border: Border.all(color: GameConfig.borderColor),
        color: GameConfig.bgColor
      ),
    );
  }
}
