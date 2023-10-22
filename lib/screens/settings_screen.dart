import 'package:flutter/material.dart';
import 'package:stacker_game/game_classes/game_config.dart';
import 'package:stacker_game/screens/components/number_selector.dart';
import 'package:stacker_game/screens/components/speed_selector.dart';
import 'package:stacker_game/static_classes/game.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int columns = Game.config().columns;
  int rows = Game.config().rows;
  int initialBlocks = Game.config().blockColumns;
  int speed = Game.config().speed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                NumberSelector(
                  selectedValue: columns,
                  label: "Columns",
                  maxNumber: 12,
                  minNumber: 3,
                  onChange: (newValue) {
                    setState(() {
                      columns = newValue!;
                      if(columns < initialBlocks + 2) {
                        initialBlocks = columns - 2;
                      }
                    });
                  }
                ),
                NumberSelector(
                    selectedValue: rows,
                    label: "Rows",
                    maxNumber: 12,
                    minNumber: 3,
                    onChange: (newValue) {
                      setState(() {
                        rows = newValue!;
                      });
                    }
                ),
              ],
            ),
            Row(
              children: [
                NumberSelector(
                  selectedValue: initialBlocks,
                  label: "Initial Blocks",
                  maxNumber: columns - 2,
                  minNumber: 1,
                  onChange: (newValue) {
                    setState(() {
                      initialBlocks = newValue!;
                    });
                  }
                ),
                SpeedSelector(
                  selectedValue: speed,
                  onChange: (newValue) {
                    setState(() {
                      speed = newValue!;
                    });
                  }
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Game.setConfig(
                  GameConfig(
                    blockColumns: initialBlocks,
                    columns: columns,
                    rows: rows,
                    speed: speed
                  )
                );
                Navigator.of(context).pop();
              },
              child: const Text("Save")
            )
          ],
        ),
      ),
    );
  }
}

