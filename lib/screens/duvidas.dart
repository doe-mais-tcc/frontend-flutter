import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/components/general/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:doe_mais/utils/navigation.dart' show Pages;

class Duvidas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      page: Pages.Duvidas,
      shrink: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Tire suas Dúvidas!',
                style: Theme.of(context).textTheme.headline1),
          ),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 750),
              child: ChatBot(),
            ),
          ),
        ],
      ),
    );
  }
}
