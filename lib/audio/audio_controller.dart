import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

const defaultPlayerCount = 4;
class AudioController {
  static AudioPlayer? _introPlayer;
  static AudioPlayer? _losePlayer;
  static AudioPlayer? _playingPlayer;
  static AudioPlayer? _wonPlayer;
  static bool musicOn = true;
  static bool sfxOn = true;

  static Future<void> initializeIntro(bool autoPlay) async {
    if(!musicOn) return;
    _introPlayer ??= AudioPlayer();
    await _introPlayer!.setSource(AssetSource('sounds/intro2.mp3'));
    if(autoPlay) {
      playIntro();
    }
  }

  static Future<void> initializeGameSounds() async {
    if(!sfxOn) return;
    _losePlayer ??= AudioPlayer();
    _wonPlayer ??= AudioPlayer();
    _playingPlayer ??= AudioPlayer();
    await _losePlayer!.setSource(AssetSource('sounds/lose.mp3'));
    await _wonPlayer!.setSource(AssetSource('sounds/won.mp3'));
    await _playingPlayer!.setSource(AssetSource('sounds/playing.mp3'));
  }

  static void playLose() {
    if(!sfxOn) return;
    _losePlayer!.seek(const Duration(milliseconds: 0));
    _losePlayer!.resume();
  }

  static void playWon() {
    if(!sfxOn) return;
    _wonPlayer!.seek(const Duration(milliseconds: 0));
    _wonPlayer!.resume();
  }

  static void playPlaying() async {
    if(!sfxOn) return;
    if(_playingPlayer == null) await initializeGameSounds();
    _playingPlayer!.setReleaseMode(ReleaseMode.loop);
    _playingPlayer!.seek(const Duration(milliseconds: 0));
    _playingPlayer!.resume();
  }

  static void stopPlaying() {
    if(!sfxOn) return;
    _playingPlayer?.stop();
  }

  static void playIntro() {
    if(!musicOn) return;
    _introPlayer!.setReleaseMode(ReleaseMode.loop);
    _introPlayer!.seek(const Duration(milliseconds: 0));
    _introPlayer!.resume();
  }

  static void disposeGameSounds() {
    _losePlayer?.dispose();
    _losePlayer = null;
    _wonPlayer?.dispose();
    _wonPlayer = null;
    _playingPlayer?.dispose();
    _playingPlayer = null;
  }

  static void disposeIntro() {
    _introPlayer?.dispose();
    _introPlayer = null;
  }

  static Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    sfxOn = prefs.getBool("sfx") ?? true;
    musicOn = prefs.getBool("music") ?? true;
  }

  static void saveSfxState(bool enabled) async {
    sfxOn = enabled;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("sfx", sfxOn);
    if(!sfxOn) {
      disposeGameSounds();
    }
  }

  static void saveMusicState(bool enabled) async {
    musicOn = enabled;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("music", musicOn);
    if(!musicOn) {
      disposeIntro();
    } else {
      AudioController.initializeIntro(true);
    }
  }
}