import 'package:flutter/material.dart';
import 'package:stacker_game/screens/components/level_list_item_background.dart';

class LevelListItem extends StatelessWidget {
  final bool isEnabled;
  final bool isDone;
  final String levelName;
  final Function() onTap;
  final TextStyle style;
  final ThemeData themeData;
  const LevelListItem({
    super.key, required this.isEnabled, required this.isDone,
    required this.levelName, required this.onTap, required this.style, required this.themeData
  });

  @override
  Widget build(BuildContext context) {
    /*

            Icon(
              isDone ? Icons.check : Icons.play_arrow,
              color: isDone ? Colors.green : Colors.blue,
            ),
     */
    return InkWell(
      onTap: onTap,
      child: LevelListItemBackground(
        themeData: themeData,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(levelName, style: style,),
              ],
            ),
            const Row(
              children: [
                Spacer(),
                Icon(Icons.star, color: Colors.orange,),
                Icon(Icons.star_border),
                Icon(Icons.star_border),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
