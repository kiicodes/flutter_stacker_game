import 'package:flutter/material.dart';

class GlobalFunctions {
  static Future<Object?> navigateTo(BuildContext context, Widget targetWidget) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) => targetWidget));
  }
}