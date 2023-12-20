import 'package:shared_preferences/shared_preferences.dart';

class IncrementalAchievements {
  static SharedPreferences? prefs;

  static Future<void> incrementAchievement({
    required String achievementKey,
    required int maxValue,
    required Function() onMaxValueReached,
  }) async {
    prefs ??= await SharedPreferences.getInstance();
    int currentValue = prefs!.getInt(achievementKey) ?? 0;

    if (currentValue < maxValue) {
      currentValue++;
      await prefs!.setInt(achievementKey, currentValue);

      if (currentValue == maxValue) {
        onMaxValueReached();
      }
    }
  }
}