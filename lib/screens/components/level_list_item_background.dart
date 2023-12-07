import 'package:flutter/material.dart';
import 'package:stacker_game/shared/shared_data.dart';

class LevelListItemBackground extends StatelessWidget {
  final Widget child;
  final ThemeData themeData;
  const LevelListItemBackground({super.key, required this.child, required this.themeData});

  @override
  Widget build(BuildContext context) {
    final liveColor = SharedData.darkMode ? themeData.colorScheme.primary : Colors.orange;
    return Container(
      width: 90,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2, color: liveColor
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: themeData.colorScheme.background
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text("Level", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: SharedData.darkMode ? null : Colors.orange),),
          ),
          child,
        ],
      ),
    );
  }
}
