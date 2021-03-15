import 'package:doe_mais/components/app_frame.dart';
import 'package:flutter/material.dart';

class Campaigns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 3,
      child: ListView(
        children: [
          Text('Campanhas', style: Theme.of(context).textTheme.headline1),
        ],
      ),
    );
  }
}
