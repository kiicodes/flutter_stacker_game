import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';
import 'package:stacker_game/shared/global_functions.dart';

const List<double> headerSizes = [30,80,80,30];

class LeaderboardList extends StatelessWidget {
  final List<LeaderboardEntry> items;
  const LeaderboardList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headers(),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final spentTime = GlobalFunctions.formatElapsedTime(Duration(milliseconds: item.spentTime));
              final lostSquaresText = item.lostSquaresCount > 0 ? "-${item.lostSquaresCount}" : "-";
              return Row(
                children: [
                  SizedBox(width: headerSizes[0], child: Text("${index + 1}")),
                  Expanded(child: Text(DateFormat('MM/dd HH:mm').format(item.datetime))),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SizedBox(width: headerSizes[1], child: Text(
                      item.calculatedPoints.toString(), textAlign: TextAlign.end,
                      style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
                    )),
                  ),
                  SizedBox(width: headerSizes[2], child: Text("${spentTime}s")),
                  SizedBox(width: headerSizes[3], child: Text(lostSquaresText, textAlign: TextAlign.center,)),
                ],
              );
            }
          ),
        ),
      ],
    );
  }

  Widget headers() {
    const textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Row(
      children: [
        SizedBox(width: headerSizes[0], child: const Text("#", style: textStyle,),),
        const Expanded(child: Text("Date", style: textStyle,)),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: SizedBox(width: headerSizes[1], child: const Text("Points", textAlign: TextAlign.end, style: textStyle,)),
        ),
        SizedBox(width: headerSizes[2], child: const Text("Time", style: textStyle,)),
        SizedBox(width: headerSizes[3], child: const Text("Sqr", style: textStyle,))
      ],
    );
  }
}
