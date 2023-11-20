import 'package:flutter/material.dart';
import 'package:stacker_game/screens/components/level_list.dart';
import 'package:stacker_game/theme/app_colors.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () { Navigator.of(context).pop(); },
                child: const Text("Back")
              )
            ),
            const Spacer(),
            Text('Choose Your Level', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),),
            const Spacer(),
            const LevelList(),
            const Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}
