import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class FilledBlock extends StatelessWidget {
  const FilledBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final blockSize = SharedData.blockSize;
    return Container(
      height: blockSize,
      width: blockSize,
      color: GameConfig.activeColor,
    );
  }
}
