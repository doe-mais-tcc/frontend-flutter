import 'package:bubble/bubble.dart';
import 'package:doe_mais/components/typing_indicator.dart';
import 'package:doe_mais/models/message.dart';
import 'package:doe_mais/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool showDots;
  ChatBubble(this.message) : this.showDots = false;

  ChatBubble.indicator()
      : this.message = null,
        this.showDots = true;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    return Bubble(
      style: message != null && message.isInput
          ? CustomTheme.inBubble(context)
          : CustomTheme.outBubble(context),
      child: showDots
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
