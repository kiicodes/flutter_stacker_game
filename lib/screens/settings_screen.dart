import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacker_game/achievements/game_achievements.dart';
import 'package:stacker_game/audio/audio_controller.dart';
import 'package:stacker_game/screens/components/audio_options.dart';
import 'package:stacker_game/screens/components/screen_background.dart';
import 'package:stacker_game/screens/components/setting_item.dart';
import 'package:stacker_game/shared/custom_back_button.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool tryingToSignIn = false;
  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isSignedIn = SharedData.usingGameServices;
    });
    SharedData.checkSignedIn((result) =>
      setState(() {
        isSignedIn = result;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemStyle = TextStyle(
      fontSize: 18,
      color: SharedData.darkMode ? null : Colors.white,
      fontWeight: FontWeight.bold
    );
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomBackButton(),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("Game Settings", textAlign: TextAlign.center, style: GoogleFonts.permanentMarker(fontSize: 35, color: Theme.of(context).textTheme.titleLarge!.color),),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SettingItem(child: Text("Privacy Policy", style: itemStyle,), onTap: () { openUrl("https://www.kiicodes.com/stacker/privacy_policy.html"); },),
              SettingItem(child: Text("Terms And Conditions", style: itemStyle), onTap: () { openUrl("https://www.kiicodes.com/stacker/terms_and_conditions.html"); },),
              const Spacer(),
              const AudioOptions(),
              const Spacer(),
              if(!SharedData.usingGameServices && !tryingToSignIn && !isSignedIn) ...[
                ElevatedButton(onPressed: () {
                  setState(() {
                    tryingToSignIn = true;
                  });
                  SharedData.signIn((result) {
                    setState(() {
                      tryingToSignIn = false;
                      isSignedIn = result;
                    });
                  });
                }, child: const Text("Connect with Game Services"))
              ],
              tryingToSignIn ? const CircularProgressIndicator() : const SizedBox(),
              if(isSignedIn || SharedData.usingGameServices) ...[
                TextButton(onPressed: () { GamesServices.showAchievements(); }, child: const Text("Achievements", style: TextStyle(fontSize: 25),))
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }
}

