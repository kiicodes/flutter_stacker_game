import 'dart:math';

import 'package:flame/components.dart';
import 'package:stacker_game/game_2d/game/new_record_2d.dart';
import 'package:stacker_game/game_2d/game/score_2d.dart';
import 'package:stacker_game/game_2d/game/score_details_2d.dart';
import 'package:stacker_game/leaderboard/manager/leaderboard_manager.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';
import 'package:stacker_game/shared/shared_data.dart';

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

  static void initScore(Vector2 size) {
    _currentScore = 0;
    _newRecord2D = NewRecord2D(Vector2(size.x / 2, size.y / 2 - 8));
    _scoreComponent = Score2D(Vector2(size.x / 2, size.y / 2 + 25));
    _scoreDetails2D = ScoreDetails2D(Vector2(size.x / 2, size.y / 2 + 40));
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

  static void showScore(List<Component> expendables, Component game, String formattedSpentTime, int spentTimeMs) {
    _animatingScore = false;
    _scoreDetails2D.updateText(formattedSpentTime);
    expendables.add(_scoreComponent);
    expendables.add(_scoreDetails2D);
    expendables.add(_newRecord2D);
    _scoreComponent.setScore(_currentScore);
    game.add(_scoreComponent);
    game.add(_scoreDetails2D);
    game.add(_newRecord2D);
    _animatingScore = true;
    _showingScore = true;
    LeaderboardManager.insertLeaderboardEntry(
      SharedData.config.getLevelKey(),
      LeaderboardEntry(
        calculatedPoints: _currentScore,
        spentTime: spentTimeMs,
        lostSquaresCount: 2,
        datetime: DateTime.now(),
      )
    );
  }

  static void addPoints(int speedMS, int lostBlocks, double timeSpent) {
    final maxRowPoints = (maxPointsPerRow - (maxPointsPerRow * (speedMS / 1000))).toInt();
    int points = (maxRowPoints * pow(1.2, -timeSpent / _losePointsEachSeconds)).toInt();
    final remainingSquares = SharedData.currentSquareQuantity - lostBlocks;
    final squarePoints = (points / SharedData.currentSquareQuantity);
    points = (squarePoints * remainingSquares).toInt();
    _currentScore += points;
  }
}