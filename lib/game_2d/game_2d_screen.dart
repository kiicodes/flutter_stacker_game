import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:stacker_game/audio/audio_controller.dart';
import 'package:stacker_game/game_2d/game/game_2d.dart';
import 'package:stacker_game/shared/custom_back_button.dart';
import 'package:stacker_game/shared/leaderboard_button.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

Game2D? game;

class Game2DScreen extends StatefulWidget {
  const Game2DScreen({super.key});

  @override
  State<Game2DScreen> createState() => _Game2DScreenState();
}

class _Game2DScreenState extends State<Game2DScreen> {
  @override
  void initState() {
    AudioController.initializeGameSounds();
    super.initState();
  }

  @override
  void dispose() {
    AudioController.disposeGameSounds();
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
            const Row(
              children: [
                LeaderboardButton(),
                Spacer(),
                CustomBackButton(noMargin: true),
              ],
            ),
            Expanded(
              child: Center(
                child: LayoutBuilder(builder: (context, constraints) {
                  game ??= Game2D(
                    customAppTheme: Theme.of(context).extension<CustomAppTheme>()!,
                    onRefreshScreen: () { setState(() {}); }
                  );
                  return Container(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                      minWidth: 550,
                    ),
                    color: Colors.green,
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
