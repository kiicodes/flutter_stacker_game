import 'package:audioplayers/audioplayers.dart';

const defaultPlayerCount = 4;
class AudioController {
  static AudioPlayer? _introPlayer;
  static AudioPlayer? _losePlayer;

  static Future<void> initializeIntro(bool autoPlay) async {
    _introPlayer ??= AudioPlayer();
    await _introPlayer!.setSource(AssetSource('sounds/intro.mp3'));
    if(autoPlay) {
      playIntro();
    }
  }

  static Future<void> initializeGameSounds() async {
    _losePlayer ??= AudioPlayer();
    await _losePlayer!.setSource(AssetSource('sounds/lose.mp3'));
  }

  static void playLose() {
    _losePlayer!.seek(const Duration(milliseconds: 0));
    _losePlayer!.resume();
  }

  static void playIntro() {
    _introPlayer!.setReleaseMode(ReleaseMode.loop);
    _introPlayer!.seek(const Duration(milliseconds: 0));
    _introPlayer!.resume();
  }

  static void disposeGameSounds() {
    _losePlayer?.dispose();
    _losePlayer = null;
  }

  static void disposeIntro() {
    _introPlayer?.dispose();
    _introPlayer = null;
  }
}