import 'package:flame/components.dart';

class BlinkEffect extends PositionComponent {
  PositionComponent child;
  double interval;
  bool _showing = false;
  double _timeSpent = 0;

  BlinkEffect({required Vector2 position, required this.child, this.interval = 0.6 }) : super(position: position, anchor: Anchor.center);

  @override
  void update(double dt) {
    _timeSpent += dt;
    if(_timeSpent >= interval) {
      if(_showing) {
        remove(child);
      } else {
        add(child);
      }
      _showing = !_showing;
      _timeSpent = 0;
    }
  }
}