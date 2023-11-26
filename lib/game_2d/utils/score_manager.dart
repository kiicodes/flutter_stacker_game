import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:stacker_game/game_2d/game/new_record_2d.dart';
import 'package:stacker_game/game_2d/game/score_2d.dart';
import 'package:stacker_game/game_2d/game/score_details_2d.dart';

class ScoreManager {
  static late Score2D _scoreComponent;
  static late ScoreDetails2D _scoreDetails2D;
  static late NewRecord2D _newRecord2D;
  static bool _showingScore = false;
  static bool _animatingScore = false;

  static void initScore(Vector2 size) {
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

  static void showScore(List<Component> expendables, Component game) {
    expendables.add(_scoreComponent);
    expendables.add(_scoreDetails2D);
    expendables.add(_newRecord2D);
    _scoreComponent.setScore(2000);
    _scoreDetails2D.updateText(12.5, 2);
    game.add(_scoreComponent);
    game.add(_scoreDetails2D);
    game.add(_newRecord2D);
    _animatingScore = true;
    _showingScore = true;
  }
}