import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/chatbot.dart';
import 'package:flutter/material.dart';

class Duvidas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 2,
      shrink: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Tire suas Dúvidas!',
              style: Theme.of(context).textTheme.headline1),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 720),
            child: ChatBot(),
          ),
        ],
      ),
    );
  }
}
