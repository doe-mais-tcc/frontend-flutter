import 'package:flutter/material.dart';

class CustomTheme {
  static TextStyle inactiveHamburger(BuildContext context) => TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  static TextStyle activeHamburger(BuildContext context) => TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  static TextStyle errorText(BuildContext context) => TextStyle(
        color: Theme.of(context).errorColor,
        fontSize: 14,
      );
}
