import 'package:flutter/material.dart';

class LevelListItemBackground extends StatelessWidget {
  final Widget child;
  final ThemeData themeData;
  const LevelListItemBackground({super.key, required this.child, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 95,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2, color: themeData.colorScheme.primary
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: themeData.colorScheme.background
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text("Lvl", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          child,
        ],
      ),
    );
  }
}
