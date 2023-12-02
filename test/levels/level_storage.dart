import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/levels/game_levels.dart';
import 'package:stacker_game/levels/level_storage.dart';

void main() {
  test('Test saving and reading level config', () async {
    SharedPreferences.setMockInitialValues({});
    GameLevels.levels[0].currentStars = 1;
    GameLevels.levels[1].currentStars = 2;
    GameLevels.levels[2].currentStars = 3;

    await LevelStorage.saveAll();
    GameLevels.levels[0].currentStars = 0;
    GameLevels.levels[1].currentStars = 0;
    GameLevels.levels[2].currentStars = 0;
    await LevelStorage.load();

    expect(GameLevels.levels[0].currentStars, 1);
    expect(GameLevels.levels[1].currentStars, 2);
    expect(GameLevels.levels[2].currentStars, 3);
  });
}