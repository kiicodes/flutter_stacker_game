import 'package:flutter/material.dart';
import 'package:stacker_game/screens/components/background_animation.dart';
import 'package:stacker_game/screens/components/game_option_button.dart';
import 'package:stacker_game/screens/components/screen_title.dart';
import 'package:stacker_game/screens/level_selection_screen.dart';
import 'package:stacker_game/shared/global_functions.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            GameOptionButton(
                              name: "Start",
                              onPressed: () {
                                GlobalFunctions.navigateTo(
                                    context, const LevelSelectionScreen());
                              },
                            ),
                            const Spacer(),
                          ],
                        )),
                    const Spacer(
                      flex: 4,
                    ),
                  ],
                ),
              ]
          )
      ),
    );
  }
}