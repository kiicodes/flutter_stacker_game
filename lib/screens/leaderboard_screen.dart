import 'package:flutter/material.dart';
import 'package:stacker_game/leaderboard/manager/leaderboard_manager.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';
import 'package:stacker_game/screens/components/leaderboard_list.dart';
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
  List<LeaderboardEntry> _items = List.empty();

  @override
  void initState() {
    currentLevel = widget.levelConfig;
    loadItems();
    super.initState();
  }

  void loadItems() async {
    final items = await LeaderboardManager.getLeaderboardEntries(currentLevel.getLevelKey());
    setState(() {
      _items = items;
    });
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
                  Text(currentLevel.name),
                  const Spacer(),
                  ElevatedButton(onPressed: () {}, child: const Text("Next")),
                ],
              ),
              const Spacer(),
              Expanded(child: LeaderboardList(items: _items,)),
              const Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
}
