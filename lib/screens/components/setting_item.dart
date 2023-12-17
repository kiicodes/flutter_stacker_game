import 'package:flutter/material.dart';
import 'package:stacker_game/shared/shared_data.dart';

class SettingItem extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const SettingItem({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: SharedData.darkMode ? Colors.black : Colors.orange,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(child: child),
      ),
    );
  }
}
