import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacker_game/screens/components/level_list.dart';
import 'package:stacker_game/screens/components/screen_background.dart';
import 'package:stacker_game/shared/custom_back_button.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            const CustomBackButton(),
            const Spacer(),
            Text('Choose Your Level', style: GoogleFonts.permanentMarker(fontSize: 30, color: Theme.of(context).textTheme.titleLarge!.color),),
            const Spacer(),
            const Expanded(
              flex: 5,
              child: Center(child: LevelList())
            ),
            const Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}
