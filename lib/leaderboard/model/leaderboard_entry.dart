class LeaderboardEntry {
  final int calculatedPoints;
  final int spentTime;
  final int lostSquaresCount;
  final String datetime;

  LeaderboardEntry({
    required this.calculatedPoints,
    required this.spentTime,
    required this.lostSquaresCount,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      'calculatedPoints': calculatedPoints,
      'spentTime': spentTime,
      'lostSquaresCount': lostSquaresCount,
      'datetime': datetime,
    };
  }

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
      calculatedPoints: map['calculatedPoints'],
      spentTime: map['spentTime'],
      lostSquaresCount: map['lostSquaresCount'],
      datetime: map['datetime'],
    );
  }
}