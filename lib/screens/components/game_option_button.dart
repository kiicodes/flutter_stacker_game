import 'package:flutter/material.dart';

class GameOptionButton extends StatelessWidget {
  final String name;
  final Function()? onPressed;
  const GameOptionButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(name),);
  }
}
