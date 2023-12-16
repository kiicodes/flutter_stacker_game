import 'dart:io';

import 'package:games_services/games_services.dart';

class GameAchievements {
  static List<Achievement> incrementalAchievements = [
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDA',
      iOSID: 'your ios id',
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDQ',
      iOSID: 'your ios id',
      steps: 60
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDg',
      iOSID: 'your ios id',
      steps: 120
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDw',
      iOSID: 'your ios id',
      steps: 30
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQEA',
      iOSID: 'your ios id',
      steps: 60
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQEQ',
      iOSID: 'your ios id',
      steps: 120
    ),
  ];

  static Achievement firstWin() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQAQ',
      iOSID: 'your ios id',
    );
  }

  static Achievement twoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQAw',
      iOSID: 'your ios id',
    );
  }

  static Achievement threeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBA',
      iOSID: 'your ios id',
    );
  }

  static Achievement fiveLvlTwoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBQ',
      iOSID: 'your ios id',
    );
  }

  static Achievement fiveLvlThreeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBg',
      iOSID: 'your ios id',
    );
  }

  static Achievement tenLvlTwoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBw',
      iOSID: 'your ios id',
    );
  }

  // #7
  static Achievement tenLvlThreeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCA',
      iOSID: 'your ios id',
    );
  }

  static Achievement allLevelsTwoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCQ',
      iOSID: 'your ios id',
    );
  }

  static Achievement allLevelsThreeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCg',
      iOSID: 'your ios id',
    );
  }

  static Achievement firstLoss() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCw',
      iOSID: 'your ios id',
    );
  }

  //#11
  static Achievement defeats30() {
    return incrementalAchievements.firstWhere((element) => element.id == 'CgkI0_7cze4FEAIQDA');
  }

  static Achievement defeats60() {
    return incrementalAchievements.firstWhere((element) => element.id == 'CgkI0_7cze4FEAIQDQ');
  }

  static Achievement defeats120() {
    return incrementalAchievements.firstWhere((element) => element.id == 'CgkI0_7cze4FEAIQDg');
  }

  static Achievement wins30() {
    return incrementalAchievements.firstWhere((element) => element.id == 'CgkI0_7cze4FEAIQDw');
  }

  static Achievement wins60() {
    return incrementalAchievements.firstWhere((element) => element.id == 'CgkI0_7cze4FEAIQEA');
  }

  static Achievement wins120() {
    return incrementalAchievements.firstWhere((element) => element.id == 'CgkI0_7cze4FEAIQEQ');
  }

  static Achievement beatOwnThreeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQEg',
      iOSID: 'your ios id',
    );
  }

  static void increment(Achievement achievement, int max) {
    if(achievement.steps < max) {
      achievement.steps += 1;
      GamesServices.increment(achievement: achievement);
    }
  }

  static Future<void> loadAchievements() async {
    List<AchievementItemData>? achievements = await GamesServices.loadAchievements();
    if(achievements != null) {
      for(AchievementItemData item in achievements!) {
        for(Achievement achievement in GameAchievements.incrementalAchievements) {
          if(Platform.isAndroid) {
            if (item.id == achievement.androidID) {
              achievement.steps = item.completedSteps;
            }
          } else {
            if (item.id == achievement.iOSID) {
              achievement.steps = item.completedSteps;
            }
          }
        }
      }
    }
  }
}