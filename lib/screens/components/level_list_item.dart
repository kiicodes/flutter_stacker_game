import 'package:flutter/material.dart';
import 'package:stacker_game/screens/components/level_list_item_background.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class LevelListItem extends StatelessWidget {
  final bool isEnabled;
  final bool isDone;
  final GameConfig gameConfig;
  final Function() onTap;
  final TextStyle style;
  final ThemeData themeData;
  const LevelListItem({
    super.key, required this.isEnabled, required this.isDone,
    required this.gameConfig, required this.onTap, required this.style, required this.themeData
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
                Text(gameConfig.name.replaceAll("Level ", ""), style: style,),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                starIcon(1),
                starIcon(2),
                starIcon(3),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget starIcon(int starNumber) {
    return Icon(gameConfig.currentStars >= starNumber ? Icons.star : Icons.star_border, color: !SharedData.darkMode ? Colors.white : gameConfig.currentStars >= starNumber ? Colors.orange : null,);
  }
}
