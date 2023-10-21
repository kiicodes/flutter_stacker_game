import 'package:flutter/material.dart';
import 'package:stacker_game/static_classes/Game.dart';

class FilledBlock extends StatelessWidget {
  const FilledBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final blockSize = Game.blockSize();
    return Container(
      height: blockSize,
      width: blockSize,
      color: Colors.red,
    );
  }
}
