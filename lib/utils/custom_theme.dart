import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
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

  static BubbleStyle outBubble(BuildContext context) => BubbleStyle(
        color: Theme.of(context).accentColor,
        padding: const BubbleEdges.all(8),
        margin: const BubbleEdges.only(top: 8),
        alignment: Alignment.topLeft,
        nip: BubbleNip.leftBottom,
        nipRadius: 3,
      );

  static BubbleStyle inBubble(BuildContext context) => BubbleStyle(
        color: Colors.white,
        padding: const BubbleEdges.all(8),
        margin: const BubbleEdges.only(top: 8),
        alignment: Alignment.topRight,
        nip: BubbleNip.rightBottom,
        nipRadius: 3,
      );
}
