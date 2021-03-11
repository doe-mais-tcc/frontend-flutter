import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        Text('Tire suas Dúvidas!',
            style: Theme.of(context).textTheme.headline1),
      ],
    );
  }
}
