import 'package:flutter/material.dart';

class GameOptionButton extends StatelessWidget {
  final String name;
  const GameOptionButton({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: null,child: Text(name),);
  }
}
