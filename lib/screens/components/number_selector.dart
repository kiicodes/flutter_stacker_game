import 'package:flutter/material.dart';

TextStyle dropdownMenuItemStyle = const TextStyle(fontSize: 22);
TextStyle dropdownLabelStyle = const TextStyle(fontSize: 22);

class NumberSelector extends StatelessWidget {
  final String label;
  final int maxNumber;
  final int minNumber;
  final int selectedValue;
  final Function(int?) onChange;
  const NumberSelector({super.key, required this.selectedValue, required this.label, required this.maxNumber, required this.minNumber, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(label, style: dropdownLabelStyle,),
          DropdownButton(
            value: selectedValue,
            items: [
              for (int i = minNumber; i <= maxNumber; i++) DropdownMenuItem(value: i, child: Text("$i", style: dropdownMenuItemStyle,)),
            ],
            onChanged: onChange,
          )
        ],
      ),
    );
  }
}
