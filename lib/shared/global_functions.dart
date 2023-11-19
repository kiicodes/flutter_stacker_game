import 'package:flutter/material.dart';

class GlobalFunctions {
  static void navigateTo(BuildContext context, Widget targetWidget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => targetWidget));
  }
}