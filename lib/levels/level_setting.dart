class LevelSetting {
  int stars;

  LevelSetting({
    required this.stars,
  });

  Map<String, dynamic> toMap() {
    return {
      'stars': stars,
    };
  }

  factory LevelSetting.fromMap(Map<String, dynamic> map) {
    return LevelSetting(
      stars: map['stars'],
    );
  }
}