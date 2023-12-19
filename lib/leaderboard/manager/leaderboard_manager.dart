import 'dart:convert';
import 'package:games_services/games_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/achievements/game_achievements.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';
import 'package:stacker_game/levels/game_levels.dart';
import 'package:stacker_game/levels/level_storage.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/shared/shared_data.dart';

class LeaderboardManager {
  static const maxEntries = 8;

  static Future<bool> insertLeaderboardEntry(GameConfig config, LeaderboardEntry entry) async {
    final levelKey = config.getLevelKey();
    int stars = entry.stars(config);
    if(stars > config.currentStars) {
      onStarsChanged(config.currentStars, stars);
      config.currentStars = stars;
      await LevelStorage.saveAll();
    }
    final prefs = await SharedPreferences.getInstance();
    final leaderboardEntries = prefs.getStringList(levelKey) ?? [];

    final jsonEncoded = jsonEncode(entry.toMap());
    leaderboardEntries.add(jsonEncoded);

    leaderboardEntries.sort((a, b) {
      final entryA = LeaderboardEntry.fromMap(jsonDecode(a));
      final entryB = LeaderboardEntry.fromMap(jsonDecode(b));
      return entryB.calculatedPoints.compareTo(entryA.calculatedPoints);
    });

    final topEntries = leaderboardEntries.take(maxEntries).toList();
    await prefs.setStringList(levelKey, topEntries);
    bool isNewRecord = LeaderboardEntry.fromMap(jsonDecode(topEntries.first)).datetime == entry.datetime;
    if(SharedData.usingGameServices && isNewRecord && topEntries.length > 1 && LeaderboardEntry.fromMap(jsonDecode(topEntries[1])).stars(config) > 2) {
      GamesServices.unlock(achievement: GameAchievements.beatOwnThreeStars());
    }
    if(isNewRecord && config.name == 'Level 10') {
      _submitScore10(entry.calculatedPoints);
    }
    return isNewRecord;
  }

  static Future<List<LeaderboardEntry>> getLeaderboardEntries(String levelKey) async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboardEntries = prefs.getStringList(levelKey) ?? [];

    return leaderboardEntries.map((entry) {
      return LeaderboardEntry.fromMap(jsonDecode(entry));
    }).toList();
  }

  static void onStarsChanged(int prevStars, int newStars) async {
    if(!SharedData.usingGameServices) {
      return;
    }
    if(prevStars < 2 && newStars >= 2) {
      await GamesServices.unlock(achievement: GameAchievements.twoStars());
      final countTwoStars = GameLevels.levels.where((element) => element.currentStars > 1).length;
      if(countTwoStars > 4) {
        await GamesServices.unlock(
            achievement: GameAchievements.fiveLvlTwoStars());
        if(countTwoStars > 9) {
          await GamesServices.unlock(achievement: GameAchievements.tenLvlTwoStars());
          if(countTwoStars == GameLevels.levels.length) {
            await GamesServices.unlock(achievement: GameAchievements.allLevelsTwoStars());
          }
        }
      }
    }
    if(prevStars < 3) {
      await GamesServices.unlock(achievement: GameAchievements.threeStars());
      final countThreeStars = GameLevels.levels.where((element) => element.currentStars > 1).length;
      if(countThreeStars > 4) {
        await GamesServices.unlock(achievement: GameAchievements.fiveLvlThreeStars());
        if(countThreeStars > 9) {
          await GamesServices.unlock(achievement: GameAchievements.tenLvlThreeStars());
          if(countThreeStars == GameLevels.levels.length) {
            await GamesServices.unlock(achievement: GameAchievements.allLevelsThreeStars());
          }
        }
      }
    }
  }

  static void _submitScore10(int value) async {
    bool isSignedIn = await GamesServices.isSignedIn;
    if(!isSignedIn) {
      await GamesServices.signIn();
      isSignedIn = await GamesServices.isSignedIn;
    }
    if(isSignedIn) {
      final result = await Leaderboards.submitScore(
          score: Score(
            androidLeaderboardID: 'CgkI0_7cze4FEAIQAg',
            iOSLeaderboardID: '',
            value: value,
          ));
      print(result);
    } else {
      print('NOT SIGNED IN');
    }
  }

  static void _loadLeaderboardScores10() async {
    final result = await Leaderboards.loadLeaderboardScores(
        androidLeaderboardID: "CgkI0_7cze4FEAIQAg",
        iOSLeaderboardID: "",
        scope: PlayerScope.global,
        timeScope: TimeScope.allTime,
        maxResults: 10);
    print(result);
  }
}