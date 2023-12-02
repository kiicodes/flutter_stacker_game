import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/levels/game_levels.dart';
import 'package:stacker_game/levels/level_setting.dart';

class LevelStorage {
  static const levelsSettingsKey = "levelsSettings";

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsStr = prefs.getString(levelsSettingsKey);
    if(settingsStr == null) return;
    final settings = jsonDecode(settingsStr) as Map<String, dynamic>;

    for(int i = 0; i < GameLevels.levels.length; i++) {
      final gameLevel = GameLevels.levels[i];

      if(settings.containsKey(gameLevel.getLevelKey())) {
        final item = LevelSetting.fromMap(settings[gameLevel.getLevelKey()]);
        gameLevel.currentStars = item.stars;
      }
    }
  }

  static Future<void> saveAll() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsStr = prefs.getString(levelsSettingsKey);
    Map<String, dynamic> settings;
    if(settingsStr == null) {
      settings = {};
    } else {
      settings = jsonDecode(settingsStr);
    }

    for(int i = 0; i < GameLevels.levels.length; i++) {
      final gameLevel = GameLevels.levels[i];

      if(settings.containsKey(gameLevel.getLevelKey())) {
        final settingItem = LevelSetting.fromMap(settings[gameLevel.getLevelKey()]);
        settingItem.stars = gameLevel.currentStars;
        settings[gameLevel.getLevelKey()] = settingItem.toMap();
      } else {
        settings[gameLevel.getLevelKey()] = LevelSetting(stars: gameLevel.currentStars).toMap();
      }
    }

    final jsonEncoded = jsonEncode(settings);
    await prefs.setString(levelsSettingsKey, jsonEncoded);
  }
}