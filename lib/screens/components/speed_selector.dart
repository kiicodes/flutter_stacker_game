import 'package:flutter/material.dart';
import 'package:stacker_game/screens/components/number_selector.dart';

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
          Text("Difficult", style: dropdownLabelStyle,),
          DropdownButton(
            value: selectedValue,
            items: [
              DropdownMenuItem(value: 0, child: Text("easy", style: dropdownMenuItemStyle,)),
              DropdownMenuItem(value: 1, child: Text("normal", style: dropdownMenuItemStyle)),
              DropdownMenuItem(value: 2, child: Text("hard", style: dropdownMenuItemStyle)),
              DropdownMenuItem(value: 3, child: Text("very hard", style: dropdownMenuItemStyle)),
            ],
            onChanged: onChange,
          )
        ],
      ),
    );
  }
}
