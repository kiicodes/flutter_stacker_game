import 'package:flutter/material.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: _titleWidget("Choose Game Render Mode"),
            ),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  _gameMode("App Game"),
                  const Spacer(),
                  _gameMode("2D Game"),
                  const Spacer()
                ],
              )
            ),
            Expanded(
              flex: 2,
              child: _settingsWidget(),
            ),
          ],
        )
      ),
    );
  }

  Widget _titleWidget(String title) {
    return Text(title);
  }

  Widget _gameMode(String name) {
    return Text(name);
  }

  Widget _settingsWidget() {
    return const Row(
      children: [
        Icon(Icons.settings),
        Text("Settings")
      ],
    );
  }
}
