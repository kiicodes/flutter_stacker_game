import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:stacker_game/achievements/game_achievements.dart';
import 'package:stacker_game/screens/components/background_animation.dart';
import 'package:stacker_game/screens/components/game_option_button.dart';
import 'package:stacker_game/screens/components/screen_background.dart';
import 'package:stacker_game/screens/components/screen_title.dart';
import 'package:stacker_game/screens/components/settings_button.dart';
import 'package:stacker_game/screens/level_selection_screen.dart';
import 'package:stacker_game/screens/settings_screen.dart';
import 'package:stacker_game/shared/global_functions.dart';
import 'package:stacker_game/shared/leaderboard_button.dart';
import 'package:stacker_game/shared/shared_data.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  void initState() {
    //signIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Stack(
            children: [
              const BackgroundAnimation(),
              Column(
                children: [
                  const Spacer(),
                  const SizedBox(
                    height: 220,
                    child: ScreenTitle(),
                  ),
                  const Spacer(flex: 2,),
                  SizedBox(
                      height: 70,
                      child: Column(
                        children: [
                          const Spacer(),
                          GameOptionButton(
                            name: "Start",
                            onPressed: () {
                              GlobalFunctions.navigateTo(context, const LevelSelectionScreen());
                            },
                          ),
                          const Spacer(),
                        ],
                      )),
                  const Spacer(flex: 2,),
                  SizedBox(
                    height: 180,
                    child: Column(
                      children: [
                        const Spacer(),
                        /*if(!tryingToSignIn) ...[Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: const LeaderboardButton()
                        )],
                        if(tryingToSignIn) ...[Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: const Text("Loading game services...")
                        )],*/
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: SettingsButton(onTap: () { GlobalFunctions.navigateTo(context, const SettingsScreen()); })
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]
        ),
      ),
    );
  }
}
