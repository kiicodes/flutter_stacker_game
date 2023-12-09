import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:stacker_game/screens/leaderboard_screen.dart';
import 'package:stacker_game/shared/global_functions.dart';

class LeaderboardButton extends StatelessWidget {
  const LeaderboardButton({ super.key });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        GlobalFunctions.navigateTo(context, LeaderboardScreen());
      },
      child: const Text("Leaderboard", style: TextStyle(fontSize: 20),)
    );
  }
}
