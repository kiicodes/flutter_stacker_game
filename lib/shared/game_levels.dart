import 'package:stacker_game/shared/game_config.dart';

class GameLevels {
  static final List<GameConfig> levels = [
    const GameConfig(columns: 6, rows: 7, squareQuantity: 3, startMs: 600, lastMs: 300),
    const GameConfig(columns: 6, rows: 9, squareQuantity: 3, startMs: 600, lastMs: 300),
    const GameConfig(columns: 6, rows: 12, squareQuantity: 3, startMs: 600, lastMs: 300),
    const GameConfig(columns: 6, rows: 7, squareQuantity: 3, startMs: 500, lastMs: 200),
    const GameConfig(columns: 6, rows: 9, squareQuantity: 3, startMs: 500, lastMs: 200),
    const GameConfig(columns: 6, rows: 12, squareQuantity: 3, startMs: 500, lastMs: 200),
    const GameConfig(columns: 6, rows: 7, squareQuantity: 3, startMs: 350, lastMs: 80),
    const GameConfig(columns: 6, rows: 9, squareQuantity: 3, startMs: 350, lastMs: 80),
    const GameConfig(columns: 6, rows: 12, squareQuantity: 3, startMs: 350, lastMs: 80),
    const GameConfig(columns: 6, rows: 7, squareQuantity: 3, startMs: 180, lastMs: 20),
  ];
}