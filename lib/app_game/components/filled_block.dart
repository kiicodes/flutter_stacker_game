import 'package:flutter/material.dart';
import 'package:stacker_game/game_classes/game_config.dart';
import 'package:stacker_game/static_classes/game_static.dart';

class FilledBlock extends StatelessWidget {
  const FilledBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final blockSize = GameStatic.blockSize();
    return Container(
      height: blockSize,
      width: blockSize,
      color: GameConfig.activeColor,
    );
  }
}
