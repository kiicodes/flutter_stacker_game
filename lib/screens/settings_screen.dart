import 'package:flutter/material.dart';
import 'package:stacker_game/game_classes/game_config.dart';
import 'package:stacker_game/screens/components/number_selector.dart';
import 'package:stacker_game/screens/components/speed_selector.dart';
import 'package:stacker_game/static_classes/game_static.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int columns = GameStatic.config().columns;
  int rows = GameStatic.config().rows;
  int initialBlocks = GameStatic.config().blockColumns;
  int speed = GameStatic.config().speed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text("Game Settings", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),),
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
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
                const Spacer(),
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
                const Spacer()
              ],
            ),
            Row(
              children: [
                const Spacer(),
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
                const Spacer(),
                SpeedSelector(
                  selectedValue: speed,
                  onChange: (newValue) {
                    setState(() {
                      speed = newValue!;
                    });
                  }
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                GameStatic.setConfig(
                  GameConfig(
                    blockColumns: initialBlocks,
                    columns: columns,
                    rows: rows,
                    speed: speed
                  )
                );
                Navigator.of(context).pop();
              },
              child: const Text("Save", style: TextStyle(fontSize: 20),)
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}

