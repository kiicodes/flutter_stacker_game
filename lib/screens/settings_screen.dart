import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/screens/components/number_selector.dart';
import 'package:stacker_game/screens/components/speed_selector.dart';
import 'package:stacker_game/shared/shared_data.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _columns = SharedData.config.columns;
  int _rows = SharedData.config.rows;
  int _initialSquareQuantity = SharedData.config.squareQuantity;
  int _level = 0;

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
                  selectedValue: _columns,
                  label: "Columns",
                  maxNumber: 12,
                  minNumber: 3,
                  onChange: (newValue) {
                    setState(() {
                      _columns = newValue!;
                      if(_columns < _initialSquareQuantity + 2) {
                        _initialSquareQuantity = _columns - 2;
                      }
                    });
                  }
                ),
                const Spacer(),
                NumberSelector(
                    selectedValue: _rows,
                    label: "Rows",
                    maxNumber: 12,
                    minNumber: 3,
                    onChange: (newValue) {
                      setState(() {
                        _rows = newValue!;
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
                  selectedValue: _initialSquareQuantity,
                  label: "Initial Squares",
                  maxNumber: _columns - 2,
                  minNumber: 1,
                  onChange: (newValue) {
                    setState(() {
                      _initialSquareQuantity = newValue!;
                    });
                  }
                ),
                const Spacer(),
                SpeedSelector(
                  selectedValue: _level,
                  onChange: (newValue) {
                    setState(() {
                      _level = newValue!;
                    });
                  }
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                /*SharedData.config = GameConfig(
                  squareQuantity: _initialSquareQuantity,
                  columns: _columns,
                  rows: _rows,
                  level: _level
                );*/
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

