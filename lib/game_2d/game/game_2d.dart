import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacker_game/achievements/game_achievements.dart';
import 'package:stacker_game/audio/audio_controller.dart';
import 'package:stacker_game/game_2d/game/background_grid_2d.dart';
import 'package:stacker_game/game_2d/game/filled_square_2d.dart';
import 'package:stacker_game/game_2d/game/stars_2d.dart';
import 'package:stacker_game/game_2d/utils/fall_animation.dart';
import 'package:stacker_game/game_2d/utils/game_2d_data.dart';
import 'package:stacker_game/game_2d/utils/level_manager.dart';
import 'package:stacker_game/game_2d/utils/score_manager.dart';
import 'package:stacker_game/levels/game_levels.dart';
import 'package:stacker_game/shared/global_functions.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class Game2D extends FlameGame with TapCallbacks {
  CustomAppTheme customAppTheme;
  late FilledSquare2D movingSquares;
  static List<Component> expendables = List.empty(growable: true);
  double myDt = 0;
  double _rowSpentTime = 0;
  late DateTime _startedDateTime;
  late TextComponent tip;
  bool _alreadyPlayed = false;
  Function() onRefreshScreen;

  Game2D({required this.customAppTheme, required this.onRefreshScreen});

  @override
  Future<void> onLoad() async {
    initTipComponent();
    ScoreManager.initScore(size, customAppTheme);
    LevelManager.initManager(size, () { reset(); onRefreshScreen(); });
    Game2DData.initValues(size, customAppTheme);
    add(BackgroundGrid2D(size, customAppTheme));
    add(tip);
    movingSquares = FilledSquare2D(1, 0);
  }

  @override
  void update(double dt) {
    ScoreManager.update(dt);

    if(!SharedData.started && FallAnimation.items.isEmpty) {
      super.update(dt);
      return;
    }

    myDt = myDt + dt;
    if(_rowSpentTime < ScoreManager.maxTimeSpent) {
      _rowSpentTime += dt;
    }
    if(myDt < Game2DData.currentSpeed / 1000.0) {
      super.update(dt);
      return;
    }

    myDt = 0;
    FallAnimation.moveIt();
    if(!SharedData.started) {
      super.update(dt);
      return;
    }

    Game2DData.moveValues();
    cutSquaresIfNeeded();

    super.update(dt);
  }

  void cutSquaresIfNeeded() {
    int newIndex = Game2DData.activeIndex;
    final squarePassedEnd = newIndex > Game2DData.rowEndIndex;
    final squarePassedStart = newIndex - SharedData.currentSquareQuantity + 1 < Game2DData.rowStartIndex;
    if (squarePassedEnd) {
      final subtractSquares = Game2DData.rowEndIndex - newIndex;
      movingSquares.quantity = SharedData.currentSquareQuantity + subtractSquares;
      newIndex = Game2DData.rowEndIndex;
    } else if (squarePassedStart) {
      final newSize = newIndex + 1 - Game2DData.rowStartIndex;
      movingSquares.quantity = newSize;
    } else {
      movingSquares.quantity = SharedData.currentSquareQuantity;
    }
    movingSquares.squareIndex = newIndex;
  }

  void reset() {
    if(expendables.isNotEmpty) {
      removeAll(expendables);
      expendables.clear();
      FallAnimation.items.clear();
    }
    Game2DData.initValues(size, customAppTheme);
    myDt = 0;
    movingSquares.squareIndex = 0;
    movingSquares.quantity = 1;
    ScoreManager.hideScore();
  }

  void startGame() {
    ScoreManager.initScore(size, customAppTheme);
    _rowSpentTime = 0;
    _startedDateTime = DateTime.now();
    reset();
    Game2DData.start();
    add(movingSquares);
  }

  void finishedRow(int lostBlocks) {
    ScoreManager.addPoints(Game2DData.currentSpeed, lostBlocks, _rowSpentTime);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!SharedData.started) {
      startGame();
    } else {
      final List<int> hitIndexes = List.empty(growable: true);
      if(SharedData.currentRow > 0) {
        for (int i = 0; i < movingSquares.quantity; i++) {
          if (Game2DData.expectedIndexes.contains(
              movingSquares.squareIndex - i)) {
            hitIndexes.add(movingSquares.squareIndex - i);
          } else {
            add(FallAnimation.addItem(movingSquares.squareIndex - i));
          }
        }
        if(hitIndexes.isNotEmpty) {
          final fixedSquare = FilledSquare2D(
            hitIndexes.length,
            hitIndexes.first,
          );
          expendables.add(fixedSquare);
          add(fixedSquare);
          finishedRow(SharedData.currentSquareQuantity - hitIndexes.length);
          SharedData.currentSquareQuantity = hitIndexes.length;
        } else {
          gameOver(false);
          return;
        }
        if(SharedData.currentRow + 1 == SharedData.config.rows) {
          gameOver(true);
          return;
        }
      } else {
        // first row is automatically a hit
        for(int i = 0; i < movingSquares.quantity; i++) {
          hitIndexes.add(movingSquares.squareIndex - i);
        }
        finishedRow(SharedData.currentSquareQuantity - movingSquares.quantity);
        SharedData.currentSquareQuantity = movingSquares.quantity;
        final fixedSquare = FilledSquare2D(hitIndexes.length, hitIndexes.first);
        expendables.add(fixedSquare);
        add(fixedSquare);
      }
      Game2DData.filledIndexes.addAll(hitIndexes);
      myDt = 0;
      Game2DData.changeRow(movingSquares, hitIndexes);
    }
    updateTipText();
  }

  void stop() {
    removeAll(expendables);
    expendables.clear();
    FallAnimation.items.clear();
    Game2DData.stop();
  }

  void gameOver(bool won) async {
    _alreadyPlayed = true;
    if(won && GameLevels.currentLevel + 1 > GameLevels.maxEnabledLevel) {
      GameLevels.maxEnabledLevel = GameLevels.currentLevel + 1;
      SharedPreferences.getInstance().then((value) => value.setInt('currentLevel', GameLevels.maxEnabledLevel));
    }
    remove(movingSquares);
    final style = TextStyle(
      color: won ? BasicPalette.yellow.color : BasicPalette.red.color,
      fontSize: 70.0,
      fontWeight: FontWeight.bold,
      shadows: const [
        Shadow(
          offset: Offset(8.0, 8.0),
          blurRadius: 10.0,
          color: Colors.black,
        )
      ]
    );
    final regular = TextPaint(style: style);
    final textComponent = TextComponent(
      text: won ? "Winner!" : "You Lose!",
      position: Vector2(size.x / 2, size.y / 2.5),
      anchor: Anchor.center,
      textRenderer: regular
    );
    expendables.add(textComponent);
    add(textComponent);
    if(won) {
      if(SharedData.usingGameServices) {
        GamesServices.unlock(achievement: GameAchievements.firstWin());
        if (GameAchievements.incrementalAchievements.isNotEmpty) {
          GameAchievements.increment(GameAchievements.wins30(), 30);
          GameAchievements.increment(GameAchievements.wins60(), 60);
          GameAchievements.increment(GameAchievements.wins120(), 120);
        }
      }
      final diff = DateTime.now().difference(_startedDateTime);
      final formattedTimeSpent = GlobalFunctions.formatElapsedTime(diff);
      ScoreManager.showScore(expendables, this, formattedTimeSpent, diff.inMilliseconds);
      LevelManager.showIfNeeded(expendables, this);
      final stars2d = Stars2D(Vector2(size.x / 2, size.y / 2.5 - 80));
      add(stars2d);
    } else if(SharedData.usingGameServices) {
      AudioController.playLose();
      GamesServices.unlock(achievement: GameAchievements.firstLoss());
      if(GameAchievements.incrementalAchievements.isNotEmpty) {
        GameAchievements.increment(GameAchievements.defeats30(), 30);
        GameAchievements.increment(GameAchievements.defeats60(), 60);
        GameAchievements.increment(GameAchievements.defeats120(), 120);
      }
    }
    SharedData.gameOver();
    updateTipText();
  }

  void initTipComponent() {
    final style = TextStyle(
      color: customAppTheme.textColor,
      fontSize: 20.0,
    );
    tip = TextComponent(
      text: "",
      position: Vector2(size.x / 2, 20),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: style)
    );
    updateTipText();
  }

  void updateTipText() {
    if(SharedData.started) {
      tip.text = "Tap to Stack";
    } else {
      if(_alreadyPlayed) {
        tip.text = "Tap to Restart";
      } else {
        tip.text = "Tap to Start";
      }
    }
  }
}

