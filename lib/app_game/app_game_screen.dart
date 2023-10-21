import 'package:flutter/material.dart';
import 'package:stacker_game/app_game/components/empty_block.dart';
import 'package:stacker_game/app_game/components/filled_block.dart';
import 'package:stacker_game/app_game/components/lose_text.dart';
import 'package:stacker_game/app_game/components/winner_text.dart';
import 'package:stacker_game/static_classes/game.dart';

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
  void dispose() {
    Game.stop();
    Game.reset();
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(isStarted ? "Tap to Stack" : "Tap to Start", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 23),),
                  ),
                  Expanded(
                      child: LayoutBuilder(builder: (_, constraints) {
                        Game.configure(constraints.maxWidth, constraints.maxHeight);
                        return Center(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: Game.gameHeight(),
                                width: constraints.maxWidth,
                                child: GridView.count(
                                    crossAxisCount: Game.config().columns,
                                    children: List.generate(Game.countItems(), (index) {
                                      final reversedIndex = (Game.countItems() - 1) - index;
                                      final item = Game.items()[reversedIndex];
                                      if(item == 0) {
                                        return const EmptyBlock();
                                      } else {
                                        return const FilledBlock();
                                      }
                                    })
                                ),
                              ),
                              !showWinner && !showLose ? const SizedBox() : SizedBox(
                                height: Game.gameHeight(),
                                width: constraints.maxWidth,
                                child: Center(
                                    child: showWinner ? const WinnerText() : const LoseText()
                                )
                              ),
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
    if(!Game.isStarted()) {
      Game.start(updateScreen, onWin, onLose);
      setState(() {
        isStarted = true;
        showLose = false;
        showWinner = false;
      });
    } else {
      //Game.move();
      Game.nextLevel();
      if(!Game.isStarted()) {
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
