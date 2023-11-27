import 'package:stacker_game/shared/game_config.dart';

class GameLevels {
  static final List<GameConfig> levels = [
    const GameConfig(name: "Level 1", columns: 6, rows: 7, squareQuantity: 3, startMs: 600, lastMs: 300),
    const GameConfig(name: "Level 2", columns: 6, rows: 9, squareQuantity: 3, startMs: 600, lastMs: 300),
    const GameConfig(name: "Level 3", columns: 6, rows: 12, squareQuantity: 3, startMs: 600, lastMs: 300),
    const GameConfig(name: "Level 4", columns: 6, rows: 7, squareQuantity: 3, startMs: 500, lastMs: 200),
    const GameConfig(name: "Level 5", columns: 6, rows: 9, squareQuantity: 3, startMs: 500, lastMs: 200),
    const GameConfig(name: "Level 6", columns: 6, rows: 12, squareQuantity: 3, startMs: 500, lastMs: 200),
    const GameConfig(name: "Level 7", columns: 6, rows: 7, squareQuantity: 3, startMs: 350, lastMs: 80),
    const GameConfig(name: "Level 8", columns: 6, rows: 9, squareQuantity: 3, startMs: 350, lastMs: 80),
    const GameConfig(name: "Level 9", columns: 6, rows: 12, squareQuantity: 3, startMs: 350, lastMs: 80),
    const GameConfig(name: "Level 10", columns: 6, rows: 7, squareQuantity: 3, startMs: 180, lastMs: 20),
    const GameConfig(name: "Level 11", columns: 6, rows: 9, squareQuantity: 3, startMs: 180, lastMs: 20),
    const GameConfig(name: "Level 12", columns: 6, rows: 12, squareQuantity: 3, startMs: 180, lastMs: 20),
    const GameConfig(name: "Level 13", columns: 10, rows: 12, squareQuantity: 2, startMs: 180, lastMs: 20),
    const GameConfig(name: "Level 14", columns: 10, rows: 12, squareQuantity: 1, startMs: 180, lastMs: 20),
  ];

  static int maxEnabledLevel = 0;
  static int currentLevel = 0;
}