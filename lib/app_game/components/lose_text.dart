import 'package:flutter/material.dart';

class LoseText extends StatelessWidget {
  const LoseText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("You Lose!", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red),);
  }
}
