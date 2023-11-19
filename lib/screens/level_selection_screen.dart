import 'package:flutter/material.dart';
import 'package:stacker_game/game_2d/game_2d_screen.dart';
import 'package:stacker_game/shared/game_levels.dart';
import 'package:stacker_game/shared/global_functions.dart';
import 'package:stacker_game/shared/shared_data.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(onPressed: () { Navigator.of(context).pop(); }, child: const Text("Back"))
            ),
            const Spacer(),
            const Text('Choose Your Level'),
            const Spacer(),
            Expanded(
              flex: 5,
              child: ListView.builder(
                itemCount: GameLevels.levels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Level ${index + 1}"),
                      ),
                      onTap: () { onLevelSelected(context, index); },
                    ),
                  );
                }
              )
            ),
            const Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }

  void onLevelSelected(BuildContext context, int level) {
    SharedData.config = GameLevels.levels[level];
    GlobalFunctions.navigateTo(context, const Game2DScreen());
  }
}
