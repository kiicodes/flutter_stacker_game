import 'package:flutter/material.dart';

class SpeedSelector extends StatelessWidget {
  final Function(int?) onChange;
  final int selectedValue;
  const SpeedSelector({super.key, required this.onChange, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("Speed"),
          DropdownButton(
            value: selectedValue,
            items: const [
              DropdownMenuItem(value: 0, child: Text("slow")),
              DropdownMenuItem(value: 1, child: Text("medium")),
              DropdownMenuItem(value: 2, child: Text("fast")),
            ],
            onChanged: onChange,
          )
        ],
      ),
    );
  }
}
