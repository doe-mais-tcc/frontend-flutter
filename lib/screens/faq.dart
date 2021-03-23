import 'package:doe_mais/components/app_frame.dart';
import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 2,
      child: Column(
        children: [
          Text('Tire suas Dúvidas!',
              style: Theme.of(context).textTheme.headline1),
        ],
      ),
    );
  }
}
