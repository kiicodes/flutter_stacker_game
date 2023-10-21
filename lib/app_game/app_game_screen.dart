import 'package:flutter/material.dart';
import 'package:stacker_game/app_game/components/empty_block.dart';
import 'package:stacker_game/app_game/components/filled_block.dart';
import 'package:stacker_game/static_classes/Game.dart';

class AppGameScreen extends StatefulWidget {
  const AppGameScreen({super.key});

  @override
  State<AppGameScreen> createState() => _AppGameScreenState();
}

class _AppGameScreenState extends State<AppGameScreen> {
  bool isStarted = false;

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
                    padding: const EdgeInsets.all(8.0),
                    child: Text(isStarted ? "Tap to positionate" : "Tap to start", style: Theme.of(context).textTheme.titleLarge,),
                  ),
                  Expanded(
                      child: LayoutBuilder(builder: (_, constraints) {
                        Game.configure(constraints.maxWidth, constraints.maxHeight);
                        return GridView.count(
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
                        );
                      })
                  )
                ],
              )
          ),
        )
    );
  }

  void startOrStopOrContinue() {
    if(!Game.isStarted()) {
      Game.start(() { updateScreen(); });
      setState(() {
        isStarted = true;
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
