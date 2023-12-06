import 'package:stacker_game/shared/game_config.dart';

class GameLevels {
  static final List<GameConfig> levels = [
    GameConfig(name: "Level 1", columns: 6, rows: 7, squareQuantity: 3, startMs: 600, lastMs: 300, twoStarsPoints: 220, threeStarsPoints: 260),
    GameConfig(name: "Level 2", columns: 6, rows: 9, squareQuantity: 3, startMs: 600, lastMs: 300, twoStarsPoints: 230, threeStarsPoints: 290),
    GameConfig(name: "Level 3", columns: 6, rows: 12, squareQuantity: 3, startMs: 600, lastMs: 300, twoStarsPoints: 235, threeStarsPoints: 300),
    GameConfig(name: "Level 4", columns: 6, rows: 7, squareQuantity: 3, startMs: 500, lastMs: 200, twoStarsPoints: 410, threeStarsPoints: 490),
    GameConfig(name: "Level 5", columns: 6, rows: 9, squareQuantity: 3, startMs: 500, lastMs: 200, twoStarsPoints: 430, threeStarsPoints: 495),
    GameConfig(name: "Level 6", columns: 6, rows: 12, squareQuantity: 3, startMs: 500, lastMs: 200, twoStarsPoints: 400, threeStarsPoints: 500),
    GameConfig(name: "Level 7", columns: 6, rows: 7, squareQuantity: 3, startMs: 350, lastMs: 80, twoStarsPoints: 780, threeStarsPoints: 870),
    GameConfig(name: "Level 8", columns: 6, rows: 9, squareQuantity: 3, startMs: 350, lastMs: 80, twoStarsPoints: 840, threeStarsPoints: 920),
    GameConfig(name: "Level 9", columns: 6, rows: 12, squareQuantity: 3, startMs: 350, lastMs: 80, twoStarsPoints: 800, threeStarsPoints: 1000),
    GameConfig(name: "Level 10", columns: 6, rows: 7, squareQuantity: 3, startMs: 180, lastMs: 20, twoStarsPoints: 1500, threeStarsPoints: 1530),
    GameConfig(name: "Level 11", columns: 6, rows: 9, squareQuantity: 3, startMs: 180, lastMs: 20, twoStarsPoints: 1600, threeStarsPoints: 1720),
    GameConfig(name: "Level 12", columns: 6, rows: 12, squareQuantity: 3, startMs: 180, lastMs: 20, twoStarsPoints: 1440, threeStarsPoints: 1600),
    GameConfig(name: "Level 13", columns: 10, rows: 12, squareQuantity: 2, startMs: 180, lastMs: 20, twoStarsPoints: 900, threeStarsPoints: 1100),
    GameConfig(name: "Level 14", columns: 10, rows: 12, squareQuantity: 1, startMs: 180, lastMs: 20, twoStarsPoints: 1200, threeStarsPoints: 1500),
  ];

  static int maxEnabledLevel = 0;
  static int currentLevel = 0;
}