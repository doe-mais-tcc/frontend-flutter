import 'package:bubble/bubble.dart';
import 'package:doe_mais/components/typing_indicator.dart';
import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  ChatBubble(this.message);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    return Bubble(
      style: message != null && message.isInput
          ? CustomTheme.inBubble(context)
          : CustomTheme.outBubble(context),
      child: message?.text == null
          ? TypingIndicator()
          : Text(
              '${message.text}',
              style: message.isInput
                  ? textStyle
                  : textStyle.copyWith(color: Colors.white),
            ),
    );
  }
}
