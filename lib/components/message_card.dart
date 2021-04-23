import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String title;
  final String message;
  MessageCard({this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).accentColor,
      ),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            '$message',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
