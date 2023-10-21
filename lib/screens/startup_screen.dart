import 'package:flutter/material.dart';
import 'package:stacker_game/screens/components/game_option_button.dart';
import 'package:stacker_game/screens/components/screen_title.dart';
import 'package:stacker_game/screens/components/settings_button.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ScreenTitle(),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Spacer(),
                  GameOptionButton(name: "App Game"),
                  Spacer(),
                  GameOptionButton(name: "2D Game"),
                  Spacer()
                ],
              )
            ),
            Expanded(
              flex: 4,
              child: SettingsButton(),
            ),
          ],
        )
      ),
    );
  }
}
