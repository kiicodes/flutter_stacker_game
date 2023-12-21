import 'package:flutter/material.dart';
import 'package:stacker_game/audio/audio_controller.dart';

class CustomBackButton extends StatelessWidget {
  final bool noMargin;
  const CustomBackButton({super.key, this.noMargin = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: noMargin ? null : const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () {
          AudioController.disposeGameSounds();
          Navigator.of(context).pop();
        },
        child: const Text("x")
      )
    );
  }
}
