import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/game/game_2d.dart';

Game2D? game;

class Game2DScreen extends StatefulWidget {
  const Game2DScreen({super.key});

  @override
  State<Game2DScreen> createState() => _Game2DScreenState();
}

class _Game2DScreenState extends State<Game2DScreen> {
  @override
  void initState() {
    game = Game2D();
    super.initState();
  }

  @override
  void dispose() {
    game?.stop();
    game = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(onPressed: () { Navigator.pop(context); }, child: const Text("Back")),
            Expanded(
              child: Center(
                child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                      minWidth: 550,
                    ),
                    child: GameWidget(
                      game: game!,
                    ),
                  );
                },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
