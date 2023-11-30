import 'package:flutter/material.dart';
import 'package:stacker_game/shared/game_config.dart';
import 'package:stacker_game/theme/custom_app_theme.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LayoutBuilder(builder: (_, constraints) {
          double cellSize = 0;
          if(constraints.maxHeight > constraints.maxWidth) {
            cellSize = constraints.maxWidth / 7;
          } else {
            cellSize = constraints.maxHeight / 7;
          }
          int columns = constraints.maxWidth ~/ cellSize;
          final totalItems = ((constraints.maxWidth / cellSize) * (constraints.maxHeight / cellSize)).ceil();
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                children: List.generate(totalItems + columns, (index) {
                  final customAppTheme = Theme.of(context).extension<CustomAppTheme>()!;
                  //if(index < stepItems || index > stepItems * 4) {
                    return Container(
                      height: cellSize,
                      width: cellSize,
                      decoration: BoxDecoration(
                          border: Border.all(color: customAppTheme.gameBorderColor!),
                          color: customAppTheme.gameBackgroundColor,
                      ),
                    );
                  /*} else {
                    return SizedBox(
                      width: cellSize,
                      height: cellSize,
                    );
                  }*/
                })
            ),
          );
        }),
        SafeArea(child: child)
      ],
    );
  }
}
