import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Stack\nAnd\nWin",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 50),
      ),
    );
  }
}
