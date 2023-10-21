import 'package:flutter/material.dart';

class WinnerText extends StatelessWidget {
  const WinnerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black26,
      child: const Text("Winner!", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.yellow),)
    );
  }
}
