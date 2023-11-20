import 'package:flutter/material.dart';

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
        duration: const Duration(milliseconds: 1500)
    );
    _controller.repeat(reverse: true);
    /*
    _controller.forward();
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.reverse();
      } else if(status == AnimationStatus.dismissed){
        _controller.forward();
      }
    });// */
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                    ((MediaQuery.of(context).size.width + 100) * _controller.value) - 85, 0.0
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.orange,
                ),
              );
            }
        ),
        const Spacer(),
      ],
    );
  }
}
