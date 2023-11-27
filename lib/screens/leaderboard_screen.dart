import 'package:flutter/material.dart';
import 'package:stacker_game/shared/custom_back_button.dart';
import 'package:stacker_game/shared/game_config.dart';

class LeaderboardScreen extends StatefulWidget {
  final GameConfig levelConfig;
  const LeaderboardScreen({super.key, required this.levelConfig});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late GameConfig currentLevel;

  @override
  void initState() {
    currentLevel = widget.levelConfig;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const CustomBackButton(),
              Text('My Leaderboard', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),),
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Previous")),
                  const Spacer(),
                  const Text("Level 1"),
                  const Spacer(),
                  ElevatedButton(onPressed: () {}, child: const Text("Next")),
                ],
              ),
              const Spacer(),
              const Text("List here"),
              const Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
}
