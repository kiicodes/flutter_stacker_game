import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Choose Game Render Mode:",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
