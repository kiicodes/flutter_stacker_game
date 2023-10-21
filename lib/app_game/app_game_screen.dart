import 'dart:async';

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
  Timer? timer;

  @override
  void dispose() {
    Game.stop();
    timer?.cancel();
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
                  Text(isStarted ? "Tap to positionate" : "Tap to start"),
                  Expanded(
                      child: LayoutBuilder(builder: (_, constraints) {
                        Game.configure(constraints.maxWidth, constraints.maxHeight);
                        return GridView.count(
                            crossAxisCount: Game.config().columns,
                            children: List.generate(Game.countItems(), (index) {
                              final item = Game.items()[index];
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
      Game.start();
      timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        if(Game.isStarted()) {
          Game.move();
          if(mounted) {
            updateScreen();
          }
        }
      });
      setState(() {
        isStarted = true;
      });
    } else {
      Game.moveRow();
      if(!Game.isStarted()) {
        timer?.cancel();
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
