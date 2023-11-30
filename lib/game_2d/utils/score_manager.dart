import 'dart:math';

import 'package:flame/components.dart';
import 'package:stacker_game/game_2d/game/new_record_2d.dart';
import 'package:stacker_game/game_2d/game/score_2d.dart';
import 'package:stacker_game/game_2d/game/score_details_2d.dart';
import 'package:stacker_game/leaderboard/manager/leaderboard_manager.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class ScoreManager {
  static const double maxTimeSpent = 20.0;
  static const double _losePointsEachSeconds = 0.5;
  static const maxPointsPerRow = 500;

  static late Score2D _scoreComponent;
  static late ScoreDetails2D _scoreDetails2D;
  static late NewRecord2D _newRecord2D;

  static bool _showingScore = false;
  static bool _animatingScore = false;
  static int _currentScore = 0;
  static int _lostSquares = 0;
  static bool _alreadyInitialized = false;

  static void initScore(Vector2 size, CustomAppTheme customAppTheme) {
    _currentScore = 0;
    _lostSquares = 0;
    if(!_alreadyInitialized) {
      _newRecord2D = NewRecord2D(Vector2(size.x / 2, size.y / 2 - 8));
      _scoreComponent = Score2D(Vector2(size.x / 2, size.y / 2 + 25), customAppTheme);
      _scoreDetails2D = ScoreDetails2D(Vector2(size.x / 2, size.y / 2 + 40), customAppTheme);
      _alreadyInitialized = true;
    }
  }

  static void update(double dt) {
    if(_animatingScore) {
      _animatingScore = _scoreComponent.updateScore(dt);
    } else if(_showingScore) {
      _newRecord2D.updateBlink(dt);
    }
  }

  static void hideScore() {
    _showingScore = false;
  }

  static void showScore(List<Component> expendables, Component game, String formattedSpentTime, int spentTimeMs) async {
    _animatingScore = false;
    _scoreDetails2D.updateText(formattedSpentTime);
    expendables.add(_scoreComponent);
    expendables.add(_scoreDetails2D);
    _scoreComponent.setScore(_currentScore);
    game.add(_scoreComponent);
    game.add(_scoreDetails2D);
    _animatingScore = true;
    _showingScore = true;
    final isNewRecord = await LeaderboardManager.insertLeaderboardEntry(
      SharedData.config.getLevelKey(),
      LeaderboardEntry(
        calculatedPoints: _currentScore,
        spentTime: spentTimeMs,
        lostSquaresCount: _lostSquares,
        datetime: DateTime.now(),
      )
    );
    if(isNewRecord) {
      expendables.add(_newRecord2D);
      game.add(_newRecord2D);
    }
  }

  static void addPoints(int speedMS, int lostSquares, double timeSpent) {
    _lostSquares += lostSquares;
    final maxRowPoints = (maxPointsPerRow - (maxPointsPerRow * (speedMS / 1000))).toInt();
    int points = (maxRowPoints * pow(1.2, -timeSpent / _losePointsEachSeconds)).toInt();
    final remainingSquares = SharedData.currentSquareQuantity - lostSquares;
    final squarePoints = (points / SharedData.currentSquareQuantity);
    points = (squarePoints * remainingSquares).toInt();
    _currentScore += points;
  }
}