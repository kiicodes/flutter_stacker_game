import 'package:flutter/material.dart';

class GlobalFunctions {
  static Future<Object?> navigateTo(BuildContext context, Widget targetWidget) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) => targetWidget));
  }

  static MaterialColor colorToMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  static String formatElapsedTime(Duration elapsedTime) {
    int hours = elapsedTime.inHours;
    int minutes = (elapsedTime.inMinutes % 60);
    int seconds = (elapsedTime.inSeconds % 60);
    int milliseconds = (elapsedTime.inMilliseconds ~/ 10) % 100;
    StringBuffer finalString = StringBuffer();
    /*if(hours < 10) {
      finalString.write("0");
    }
    finalString.write("$hours:");*/
    if(minutes < 10) {
      finalString.write("0");
    }
    finalString.write("$minutes:");
    if(seconds < 10) {
      finalString.write("0");
    }
    finalString.write("$seconds.");
    if(milliseconds < 10) {
      finalString.write("0");
    }
    finalString.write("$milliseconds");
    return finalString.toString();
  }
}