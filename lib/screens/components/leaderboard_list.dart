import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacker_game/leaderboard/model/leaderboard_entry.dart';
import 'package:stacker_game/shared/global_functions.dart';

const List<double> headerSizes = [30,60,80,30];

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
              return Row(
                children: [
                  SizedBox(width: headerSizes[0], child: Text("$index")),
                  Expanded(child: Text(DateFormat('MM/dd HH:mm').format(item.datetime))),
                  SizedBox(width: headerSizes[1], child: Text(item.calculatedPoints.toString())),
                  SizedBox(width: headerSizes[2], child: Text("${spentTime}s")),
                  SizedBox(width: headerSizes[3], child: Text(item.lostSquaresCount.toString())),
                ],
              );
            }
          ),
        ),
      ],
    );
  }

  Widget headers() {
    return Row(
      children: [
        SizedBox(width: headerSizes[0], child: const Text("#"),),
        const Expanded(child: Text("Date")),
        SizedBox(width: headerSizes[1], child: const Text("Points")),
        SizedBox(width: headerSizes[2], child: const Text("Time")),
        SizedBox(width: headerSizes[3], child: const Text("Lost"))
      ],
    );
  }
}
