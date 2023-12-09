import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';
import 'package:stacker_game/screens/components/background_animation.dart';
import 'package:stacker_game/screens/components/game_option_button.dart';
import 'package:stacker_game/screens/components/screen_background.dart';
import 'package:stacker_game/screens/components/screen_title.dart';
import 'package:stacker_game/screens/level_selection_screen.dart';
import 'package:stacker_game/shared/global_functions.dart';
import 'package:stacker_game/shared/leaderboard_button.dart';
import 'package:stacker_game/shared/shared_data.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  bool tryingToSignIn = true;
  bool isSignedIn = false;
  @override
  void initState() {
    signIn();
    super.initState();
  }

  void signIn() async {
    try {
      final result = await GamesServices.signIn();
      final isSignedInResult = await GamesServices.isSignedIn;
      setState(() {
        tryingToSignIn = false;
        isSignedIn = isSignedInResult;
      });
      print('Is signed in? $isSignedIn: Sign in result: $result');
    } on PlatformException catch (e) {
      setState(() {
        tryingToSignIn = false;
      });
      print('Failed to sign in');
      print(e);
    }
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
                  const SizedBox(
                    height: 220,
                    child: ScreenTitle(),
                  ),
                  Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          const Spacer(),
                          tryingToSignIn ? const CircularProgressIndicator() : GameOptionButton(
                            name: "Start",
                            onPressed: () {
                              GlobalFunctions.navigateTo(context, const LevelSelectionScreen());
                            },
                          ),
                          const Spacer(),
                        ],
                      )),
                  const Spacer(
                    flex: 2,
                  ),
                  if(isSignedIn) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const Text("Play Games Leaderboard")
                    ),
                    TextButton(onPressed: () { GamesServices.showAchievements(); }, child: const Text("Achievements"))
                  ],
                  if(!tryingToSignIn && !isSignedIn) ...[Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const LeaderboardButton()
                  )],
                  if(tryingToSignIn) ...[Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const Text("Loading game services...")
                  )],
                ],
              ),
            ]
        ),
      ),
    );
  }
}
