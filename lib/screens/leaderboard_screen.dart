import 'package:flutter/material.dart';
import 'package:stacker_game/leaderboard/manager/leaderboard_manager.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';
import 'package:stacker_game/screens/components/leaderboard_list.dart';
import 'package:stacker_game/screens/components/screen_background.dart';
import 'package:stacker_game/shared/custom_back_button.dart';
import 'package:stacker_game/shared/game_levels.dart';
import 'package:stacker_game/shared/shared_data.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int levelIndex = 0;

  List<LeaderboardEntry> _items = List.empty();

  @override
  void initState() {
    levelIndex = SharedData.config.levelIndex();
    loadItems();
    super.initState();
  }

  void loadItems() async {
    final currentLevel = GameLevels.levels[levelIndex];
    final items = await LeaderboardManager.getLeaderboardEntries(currentLevel.getLevelKey());
    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLevel = GameLevels.levels[levelIndex];
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const CustomBackButton(),
              Text('My Leaderboard', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),),
              Row(
                children: [
                  levelIndex == 0 ? const SizedBox(width: 80,) : ElevatedButton(onPressed: () {
                    setState(() {
                      levelIndex -= 1;
                      loadItems();
                    });
                  }, child: const Text("Previous")),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: Text(currentLevel.name)),
                  const Spacer(),
                  levelIndex + 1 == GameLevels.levels.length ? const SizedBox(width: 80,) : ElevatedButton(onPressed: () {
                    setState(() {
                      levelIndex += 1;
                      loadItems();
                    });
                  }, child: const Text("Next")),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).textTheme.titleLarge!.color!),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: Theme.of(context).colorScheme.background
                  ),
                  child: LeaderboardList(items: _items,)
                )
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
