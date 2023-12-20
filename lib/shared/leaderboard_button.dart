import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:stacker_game/screens/leaderboard_screen.dart';
import 'package:stacker_game/shared/global_functions.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class LeaderboardButton extends StatelessWidget {
  const LeaderboardButton({ super.key });

  @override
  Widget build(BuildContext context) {
    final customAppTheme = Theme.of(context).extension<CustomAppTheme>()!;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: SharedData.darkMode ? null : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: SharedData.darkMode ? null : Border.all(color: SharedData.darkMode ? customAppTheme.gameBorderColor! : Colors.orange)
      ),
      child: TextButton(
        onPressed: () {
          GlobalFunctions.navigateTo(context, LeaderboardScreen());
        },
        child: Text("Leaderboard",
          style: TextStyle(
            fontSize: 20,
            color: SharedData.darkMode ? null : Colors.orange,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}
