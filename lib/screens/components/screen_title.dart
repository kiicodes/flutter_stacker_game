import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacker_game/theme/app_colors.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Stack\nAnd\nWin",
        textAlign: TextAlign.center,
        style: GoogleFonts.permanentMarker(fontSize: 50, color: AppColors.defaultColor),
      ),
    );
  }
}
