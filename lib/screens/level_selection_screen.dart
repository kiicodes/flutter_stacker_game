import 'package:flutter/material.dart';
import 'package:stacker_game/screens/components/level_list.dart';
import 'package:stacker_game/shared/custom_back_button.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomBackButton(),
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
