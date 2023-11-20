import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/game_2d/game_2d_screen.dart';
import 'package:stacker_game/shared/game_levels.dart';
import 'package:stacker_game/shared/global_functions.dart';
import 'package:stacker_game/shared/shared_data.dart';

class LevelList extends StatefulWidget {
  const LevelList({super.key});

  @override
  State<LevelList> createState() => _LevelListState();
}

class _LevelListState extends State<LevelList> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _currentLevel;

  @override
  void initState() {
    super.initState();
    _currentLevel = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('currentLevel') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final levelStyle = Theme.of(context).textTheme.titleLarge!;

    return Expanded(
      flex: 5,
      child: FutureBuilder(
        future: _currentLevel,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                GameLevels.maxEnabledLevel = snapshot.data!;
                return ListView.builder(
                  itemCount: GameLevels.levels.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(GameLevels.maxEnabledLevel >= index) {
                      final levelDone = GameLevels.maxEnabledLevel > index;
                      return Center(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  levelDone ? Icons.check : Icons.play_arrow,
                                  color: levelDone ? Colors.green : Colors.blue,
                                ),
                                Text("Level ${index + 1}", style: levelStyle,),
                              ],
                            ),
                          ),
                          onTap: () {
                            onLevelSelected(context, index);
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.lock),
                              Text("Level ${index + 1}", style: levelStyle,)
                            ],
                          ),
                        ),
                      );
                    }
                  }
                );
              }
          }
        }
      ),
    );
  }

  void onLevelSelected(BuildContext context, int level) async {
    SharedData.config = GameLevels.levels[level];
    GameLevels.currentLevel = level;
    await GlobalFunctions.navigateTo(context, const Game2DScreen());
    setState(() {
      _currentLevel = _prefs.then((SharedPreferences prefs) {
        return prefs.getInt('currentLevel') ?? 0;
      });
    });
  }
}
