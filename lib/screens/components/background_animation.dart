import 'package:flutter/material.dart';
import 'package:stacker_game/theme/app_colors.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1800)
    );
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final customWidth = (MediaQuery.of(context).size.width + 100);
    const endDiff = 75;
    final customAppTheme = Theme.of(context).extension<CustomAppTheme>()!;
    return Column(
      children: [
        const SizedBox(height: 220,),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                  (customWidth * _controller.value) - endDiff, 0.0
              ),
              child: Container(
                width: 50,
                height: 50,
                color: customAppTheme.activeColor,
              ),
            );
          }
        ),
        const Spacer(flex: 3,),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double newPosition = customWidth - (customWidth * _controller.value) - endDiff;
            return Transform.translate(
              offset: Offset(
                newPosition,
                0.0,
              ),
              child: Container(
                width: 50.0,
                height: 50.0,
                color: customAppTheme.activeColor,
              ),
            );
          },
        ),
        const Spacer(flex: 5,),
      ],
    );
  }
}
