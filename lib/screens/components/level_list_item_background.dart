import 'package:flutter/material.dart';

class LevelListItemBackground extends StatelessWidget {
  final Widget child;
  const LevelListItemBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 95,
      color: Colors.orange,
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
