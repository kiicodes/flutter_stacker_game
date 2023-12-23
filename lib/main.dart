import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_services/games_services.dart';
import 'package:stacker_game/screens/startup_screen.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:stacker_game/theme/custom_dark_theme.dart';
import 'package:stacker_game/theme/custom_light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SharedData.darkMode = true;//MediaQuery.of(context).platformBrightness == Brightness.dark;
    return MaterialApp(
      title: 'Stacker (Stack And Win)',
      debugShowCheckedModeBanner: false,
      theme: CustomDarkTheme.getThemeData(),
      darkTheme: CustomDarkTheme.getThemeData(),
      home: const StartupScreen(),
    );
  }
}
