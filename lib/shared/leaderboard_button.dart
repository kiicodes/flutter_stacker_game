import 'package:flutter/material.dart';
import 'package:stacker_game/screens/leaderboard_screen.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/global_functions.dart';

class LeaderboardButton extends StatelessWidget {
  final GameConfig levelConfig;
  const LeaderboardButton({ super.key, required this.levelConfig });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        GlobalFunctions.navigateTo(context, LeaderboardScreen(levelConfig: levelConfig));
      },
      child: const Text("Leaderboard", style: TextStyle(fontSize: 20),)
    );
  }
}
