import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:stacker_game/achievements/game_achievements.dart';
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
  Widget build(BuildContext context) {
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
                      child: Text("Game Settings", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SettingItem(child: const Text("Privacy Policy"), onTap: () { openUrl("https://www.kiicodes.com/stacker/privacy_policy.html"); },),
              SettingItem(child: const Text("Terms And Conditions"), onTap: () { openUrl("https://www.kiicodes.com/stacker/terms_and_conditions.html"); },),
              const Spacer(),
              if(!SharedData.usingGameServices && !tryingToSignIn && !isSignedIn) ...[
                ElevatedButton(onPressed: () {
                  setState(() {
                    tryingToSignIn = true;
                  });
                  signIn();
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

  void signIn() async {
    try {
      await GamesServices.signIn().timeout(const Duration(seconds: 15));
      final isSignedInResult = await GamesServices.isSignedIn.timeout(const Duration(seconds: 2));
      await GameAchievements.loadAchievements().timeout(const Duration(seconds: 20));
      setState(() {
        tryingToSignIn = false;
        isSignedIn = isSignedInResult;
        SharedData.usingGameServices = isSignedInResult;
      });
    } catch (e) {
      if(kDebugMode) {
        print("An error occurred trying to sign in to game services: $e");
        rethrow;
      }
    } finally {
      setState(() {
        tryingToSignIn = false;
      });
    }
  }
}

