import 'package:flutter/material.dart';
import 'package:stacker_game/app_game/components/empty_block.dart';
import 'package:stacker_game/app_game/components/filled_block.dart';
import 'package:stacker_game/app_game/components/lose_text.dart';
import 'package:stacker_game/app_game/components/winner_text.dart';
import 'package:stacker_game/app_game/static_classes/app_game_static.dart';
import 'package:stacker_game/shared/shared_data.dart';

class AppGameScreen extends StatefulWidget {
  const AppGameScreen({super.key});

  @override
  State<AppGameScreen> createState() => _AppGameScreenState();
}

class _AppGameScreenState extends State<AppGameScreen> {
  bool isStarted = false;
  bool showWinner = false;
  bool showLose = false;

  @override
  void initState() {
    GameStatic.reset();
    SharedData.initValues();
    super.initState();
  }

  @override
  void dispose() {
    GameStatic.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: startOrStopOrContinue,
          child: SafeArea(
              child: Column(
                children: [
                  ElevatedButton(onPressed: () { Navigator.pop(context); }, child: const Text("Back")),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(isStarted ? "Tap to Stack" : "Tap to Start", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 23),),
                  ),
                  Expanded(
                      child: LayoutBuilder(builder: (_, constraints) {
                        SharedData.onDimensionsSet(constraints.maxWidth, constraints.maxHeight);
                        return Center(
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: GameStatic.gameHeight(),
                                  width: GameStatic.gameWidth(),
                                  child: GridView.count(
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: SharedData.config.columns,
                                    children: List.generate(GameStatic.countItems(), (index) {
                                      final reversedIndex = (GameStatic.countItems() - 1) - index;
                                      final item = GameStatic.items()[reversedIndex];
                                      if(item == 0) {
                                        return const EmptyBlock();
                                      } else {
                                        return const FilledBlock();
                                      }
                                    })
                                  ),
                                ),
                              ),
                              if(showWinner || showLose) ...[SizedBox(
                                height: GameStatic.gameHeight(),
                                width: constraints.maxWidth,
                                child: Center(
                                    child: showWinner ? const WinnerText() : const LoseText()
                                )
                              )],
                            ]
                          ),
                        );
                      })
                  )
                ],
              )
          ),
        )
    );
  }

  void onWin() {
    setState(() {
      showWinner = true;
    });
  }

  void onLose() {
    setState(() {
      showLose = true;
    });
  }

  void startOrStopOrContinue() {
    if(!SharedData.started) {
      GameStatic.start(updateScreen, onWin, onLose);
      setState(() {
        isStarted = true;
        showLose = false;
        showWinner = false;
      });
    } else {
      GameStatic.nextLevel();
      if(!SharedData.started) {
        setState(() {
          isStarted = false;
        });
      }
      updateScreen();
    }
  }

  void updateScreen() {
    setState(() {});
  }
}
