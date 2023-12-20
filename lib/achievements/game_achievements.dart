import 'dart:io';

import 'package:games_services/games_services.dart';
import 'package:stacker_game/achievements/incremental_achievements.dart';

class GameAchievements {
  static final maxIncrement = {
    'CgkI0_7cze4FEAIQDA': 30,
    'CgkI0_7cze4FEAIQDQ': 60,
    'CgkI0_7cze4FEAIQDg': 120,
    'CgkI0_7cze4FEAIQDw': 30,
    'CgkI0_7cze4FEAIQEA': 60,
    'CgkI0_7cze4FEAIQEQ': 120,
  };

  static List<Achievement> incrementalAchievements = [
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDA',
      iOSID: 'CgkI0_7cze4FEAIQDA',
      steps: 30,
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDQ',
      iOSID: 'CgkI0_7cze4FEAIQDQ',
      steps: 60
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDg',
      iOSID: 'CgkI0_7cze4FEAIQDg',
      steps: 120
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQDw',
      iOSID: 'CgkI0_7cze4FEAIQDw',
      steps: 30,
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQEA',
      iOSID: 'CgkI0_7cze4FEAIQEA',
      steps: 60
    ),
    Achievement(
      androidID: 'CgkI0_7cze4FEAIQEQ',
      iOSID: 'CgkI0_7cze4FEAIQEQ',
      steps: 120
    ),
  ];

  static Achievement firstWin() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQAQ',
      iOSID: 'CgkI0_7cze4FEAIQAQ',
    );
  }

  static Achievement twoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQAw',
      iOSID: 'CgkI0_7cze4FEAIQAw',
    );
  }

  static Achievement threeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBA',
      iOSID: 'CgkI0_7cze4FEAIQBA',
    );
  }

  static Achievement fiveLvlTwoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBQ',
      iOSID: 'CgkI0_7cze4FEAIQBQ',
    );
  }

  static Achievement fiveLvlThreeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBg',
      iOSID: 'CgkI0_7cze4FEAIQBg',
    );
  }

  static Achievement tenLvlTwoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQBw',
      iOSID: 'CgkI0_7cze4FEAIQBw',
    );
  }

  // #7
  static Achievement tenLvlThreeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCA',
      iOSID: 'CgkI0_7cze4FEAIQCA',
    );
  }

  static Achievement allLevelsTwoStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCQ',
      iOSID: 'CgkI0_7cze4FEAIQCQ',
    );
  }

  static Achievement allLevelsThreeStars() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCg',
      iOSID: 'CgkI0_7cze4FEAIQCg',
    );
  }

  static Achievement firstLoss() {
    return Achievement(
      androidID: 'CgkI0_7cze4FEAIQCw',
      iOSID: 'CgkI0_7cze4FEAIQCw',
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
      iOSID: 'CgkI0_7cze4FEAIQEg',
    );
  }

  static void increment(Achievement achievement, int max) {
    if(Platform.isIOS) {
      IncrementalAchievements.incrementAchievement(
        achievementKey: achievement.iOSID,
        maxValue: maxIncrement[achievement.iOSID]!,
        onMaxValueReached: () {
          GamesServices.unlock(achievement: achievement);
        }
      );
    } else {
      if (achievement.steps < max) {
        achievement.steps += 1;
        GamesServices.increment(achievement: achievement);
      }
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
            /*
            item = {AchievementItemData}
               id = "CgkI0_7cze4FEAIQCg"
               name = "incrível, você acabou de terminar o jogo!"
               description = "Obtenha o prêmio de três estrelas em todos os níveis."
               lockedImage = "iVBORw0KGgoAAAANSUhEUgAAACUAAAAlCAQAAABvl+iIAAANBGlDQ1BrQ0dDb2xvclNwYWNlR2VuZXJpY0dyYXlHYW1tYTJfMgAAWIWlVwdck9cWv9/IAJKwp4ywkWVA"
               unlockedImage = "iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKAC"
               completedSteps = 0
               totalSteps = 100
               unlocked = false
             */
          }
        }
      }
    }
  }
}