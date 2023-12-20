import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsButton extends StatelessWidget {
  final Function()? onTap;
  const SettingsButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.settings, size: 45, color: Theme.of(context).textTheme.titleLarge!.color,),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("Settings",
                    style: GoogleFonts.permanentMarker(fontSize: 30, color: Theme.of(context).textTheme.titleLarge!.color),)
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
