import 'package:bubble/bubble.dart';
import 'package:doe_mais/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isInput;
  ChatBubble({this.text, this.isInput = true});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline3;
    return Bubble(
      style: isInput
          ? CustomTheme.inBubble(context)
          : CustomTheme.outBubble(context),
      child: Text(
        '$text',
        style: isInput ? textStyle : textStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
