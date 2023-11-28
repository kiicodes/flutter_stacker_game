import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';

class LeaderboardManager {
  static const maxEntries = 8;

  static Future<bool> insertLeaderboardEntry(String levelKey, LeaderboardEntry entry) async {
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
    return LeaderboardEntry.fromMap(jsonDecode(topEntries.first)).datetime == entry.datetime;
  }

  static Future<List<LeaderboardEntry>> getLeaderboardEntries(String levelKey) async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboardEntries = prefs.getStringList(levelKey) ?? [];

    return leaderboardEntries.map((entry) {
      return LeaderboardEntry.fromMap(jsonDecode(entry));
    }).toList();
  }
}