import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.settings),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Settings",
                  style: Theme.of(context).textTheme.titleLarge,)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
