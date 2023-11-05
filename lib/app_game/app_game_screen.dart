import 'package:flutter/material.dart';
import 'package:stacker_game/app_game/components/empty_square.dart';
import 'package:stacker_game/app_game/components/filled_square.dart';
import 'package:stacker_game/app_game/components/lose_text.dart';
import 'package:stacker_game/app_game/components/winner_text.dart';
import 'package:stacker_game/app_game/app_utils/app_game_data.dart';
import 'package:stacker_game/shared/shared_data.dart';

class AppGameScreen extends StatefulWidget {
  const AppGameScreen({super.key});

  @override
  State<AppGameScreen> createState() => _AppGameScreenState();
}

class _AppGameScreenState extends State<AppGameScreen> {
  bool _isStarted = false;
  bool _showWinner = false;
  bool _showLose = false;

  @override
  void initState() {
    AppGameData.reset();
    super.initState();
  }

  @override
  void dispose() {
    AppGameData.stop();
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
                    child: Text(_isStarted ? "Tap to Stack (App game)" : "Tap to Start (App game)", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 23),),
                  ),
                  Expanded(
                      child: LayoutBuilder(builder: (_, constraints) {
                        SharedData.onDimensionsSet(constraints.maxWidth, constraints.maxHeight);
                        return Center(
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: AppGameData.gameHeight(),
                                  width: AppGameData.gameWidth(),
                                  child: GridView.count(
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: SharedData.config.columns,
                                    children: List.generate(AppGameData.countItems(), (index) {
                                      final reversedIndex = (AppGameData.countItems() - 1) - index;
                                      final item = AppGameData.squareState![reversedIndex];
                                      if(!item) {
                                        return const EmptySquare();
                                      } else {
                                        return const FilledSquare();
                                      }
                                    })
                                  ),
                                ),
                              ),
                              if(_showWinner || _showLose) ...[SizedBox(
                                height: AppGameData.gameHeight(),
                                width: constraints.maxWidth,
                                child: Center(
                                    child: _showWinner ? const WinnerText() : const LoseText()
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
      _showWinner = true;
    });
  }

  void onLose() {
    setState(() {
      _showLose = true;
    });
  }

  void startOrStopOrContinue() {
    if(!SharedData.started) {
      AppGameData.start(updateScreen, onWin, onLose);
      setState(() {
        _isStarted = true;
        _showLose = false;
        _showWinner = false;
      });
    } else {
      AppGameData.nextLevel();
      if(!SharedData.started) {
        setState(() {
          _isStarted = false;
        });
      }
      updateScreen();
    }
  }

  void updateScreen() {
    setState(() {});
  }
}
