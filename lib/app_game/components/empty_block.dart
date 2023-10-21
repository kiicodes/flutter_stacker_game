import 'package:flutter/material.dart';
import 'package:stacker_game/static_classes/Game.dart';

class EmptyBlock extends StatelessWidget {
  const EmptyBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final blockSize = Game.blockSize();
    return Container(
      height: blockSize,
      width: blockSize,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.black
      ),
    );
  }
}
