import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';

class LeaderboardManager {
  static const maxEntries = 8;

  static Future<void> insertLeaderboardEntry(String levelKey, LeaderboardEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboardEntries = prefs.getStringList(levelKey) ?? [];

    leaderboardEntries.add(jsonEncode(entry.toMap()));

    leaderboardEntries.sort((a, b) {
      final entryA = LeaderboardEntry.fromMap(jsonDecode(a));
      final entryB = LeaderboardEntry.fromMap(jsonDecode(b));
      return entryB.calculatedPoints.compareTo(entryA.calculatedPoints);
    });

    final top5Entries = leaderboardEntries.take(maxEntries).toList();
    await prefs.setStringList(levelKey, top5Entries);
  }

  static Future<List<LeaderboardEntry>> getLeaderboardEntries(String levelKey) async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboardEntries = prefs.getStringList(levelKey) ?? [];

    return leaderboardEntries.map((entry) {
      return LeaderboardEntry.fromMap(jsonDecode(entry));
    }).toList();
  }
}