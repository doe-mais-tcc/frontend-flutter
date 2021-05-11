import 'package:doe_mais/components/utils/typing_indicator.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:doe_mais/models/message.dart';
import 'package:flutter/material.dart';

class CustomChatBubble extends ChatBubble {
  //Theme values
  static const _margin = const EdgeInsets.only(top: 6);
  static const double _elevation = 4;
  static const _shadowColor = Colors.black26;
  static var _inClipper = ChatBubbleClipper2(
    type: BubbleType.receiverBubble,
    nipWidth: 8,
    radius: 12,
  );
  static var _outClipper = ChatBubbleClipper2(
    type: BubbleType.sendBubble,
    nipWidth: 8,
    radius: 12,
  );

  final Message message;
  CustomChatBubble(this.message);

  Widget outBubble(ThemeData theme) => ChatBubble(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SelectableText(
            message.text,
            style: theme.textTheme.bodyText1,
          ),
        ),
        backGroundColor: Colors.white,
        alignment: Alignment.centerRight,
        margin: _margin,
        elevation: _elevation,
        shadowColor: _shadowColor,
        clipper: _outClipper,
      );

  Widget inBubble(ThemeData theme) => ChatBubble(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SelectableText(
            message.text,
            style: theme.textTheme.bodyText1.copyWith(color: Colors.white),
          ),
        ),
        backGroundColor: theme.colorScheme.primary,
        alignment: Alignment.centerLeft,
        margin: _margin,
        elevation: _elevation,
        shadowColor: _shadowColor,
        clipper: _inClipper,
      );

  Widget loadingBubble(ThemeData theme) => ChatBubble(
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TypingIndicator(),
        ),
        backGroundColor: theme.colorScheme.primary,
        alignment: Alignment.centerLeft,
        margin: _margin,
        elevation: _elevation,
        shadowColor: _shadowColor,
        clipper: _inClipper,
      );

  @override
  EdgeInsets setPadding() => EdgeInsets.all(0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (message.text == null)
      return loadingBubble(theme);
    else if (message.isSender)
      return outBubble(theme);
    else
      return inBubble(theme);
  }
}
