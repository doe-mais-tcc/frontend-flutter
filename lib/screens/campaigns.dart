import 'package:flutter/material.dart';

class Campaigns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Campanhas', style: Theme.of(context).textTheme.headline1),
      ],
    );
  }
}
