import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:stacker_game/screens/components/number_selector.dart';
import 'package:stacker_game/screens/components/screen_background.dart';
import 'package:stacker_game/screens/components/setting_item.dart';
import 'package:stacker_game/screens/components/speed_selector.dart';
import 'package:stacker_game/shared/custom_back_button.dart';
import 'package:stacker_game/shared/shared_data.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

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
              TextButton(onPressed: () { GamesServices.showAchievements(); }, child: const Text("Achievements", style: TextStyle(fontSize: 25),)),
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

