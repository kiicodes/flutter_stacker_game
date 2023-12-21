import 'package:flutter/material.dart';
import 'package:stacker_game/audio/audio_controller.dart';
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
  bool tryingToSignIn = true;
  bool isSignedIn = false;

  @override
  void dispose() {
    AudioController.disposeIntro();
    super.dispose();
  }

  @override
  void initState() {
    AudioController.initializeIntro(true);
    SharedData.signIn((result) {
      setState(() {
        tryingToSignIn = false;
        isSignedIn = result;
      });
    });
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
                      height: tryingToSignIn ? 90 : 70,
                      child: Column(
                        children: [
                          const Spacer(),
                          if(tryingToSignIn) ...[
                            const CircularProgressIndicator(),
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: const Text("Loading game services...")
                          )] else
                            ...[
                              GameOptionButton(
                                name: "Start",
                                onPressed: () async {
                                  AudioController.disposeIntro();
                                  await GlobalFunctions.navigateTo(context, const LevelSelectionScreen());
                                  await AudioController.initializeIntro(true);
                                },
                              )
                            ],
                          const Spacer(),
                        ],
                      )),
                  const Spacer(flex: 2,),
                  SizedBox(
                    height: 180,
                    child: Column(
                      children: [
                        const Spacer(),
                        if(!tryingToSignIn) ...[Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: const LeaderboardButton()
                        )],
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
