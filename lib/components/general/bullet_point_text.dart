import 'package:flutter/material.dart';

class BulletPointText extends StatelessWidget {
  final String text;
  BulletPointText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.brightness_1,
            color: Theme.of(context).primaryColor,
            size: 8,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              '$text',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
