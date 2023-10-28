import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/game/game_2d.dart';

final Game game = Game2D();

class Game2DScreen extends StatelessWidget {
  const Game2DScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
                minWidth: 550,
              ),
              child: GameWidget(
                game: game,
              ),
            );
          },
        ),
    ),
      ));
  }
}

