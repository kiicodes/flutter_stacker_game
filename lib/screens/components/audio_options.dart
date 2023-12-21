import 'package:flutter/material.dart';
import 'package:stacker_game/audio/audio_controller.dart';

class AudioOptions extends StatefulWidget {
  const AudioOptions({super.key});

  @override
  State<AudioOptions> createState() => _AudioOptionsState();
}

class _AudioOptionsState extends State<AudioOptions> {
  bool _musicOn = AudioController.musicOn;
  bool _sfxOn = AudioController.sfxOn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          children: [
            IconButton(icon: Icon(_musicOn ? Icons.volume_up : Icons.volume_off, size: 50,), onPressed: () { _toggleMusic(); },),
            const Text("Music")
          ],
        ),
        const Spacer(),
        Column(
          children: [
            IconButton(icon: Icon(_sfxOn ? Icons.volume_up : Icons.volume_off, size: 50,), onPressed: () { _toggleSfx(); },),
            const Text("Sounds")
          ],
        ),
        const Spacer(),
      ],
    );
  }

  void _toggleSfx() {
    setState(() {
      _sfxOn = !_sfxOn;
      AudioController.saveSfxState(_sfxOn);
    });
  }

  void _toggleMusic() {
    setState(() {
      _musicOn = !_musicOn;
      AudioController.saveMusicState(_musicOn);
    });
  }
}
