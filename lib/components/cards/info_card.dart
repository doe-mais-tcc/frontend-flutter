import 'package:doe_mais/models/info.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Info info;
  InfoCard(this.info);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                info.title,
                style: themeData.textTheme.headline2,
              ),
            ),
            Column(
              children: info.items
                  .map((e) => ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: themeData.primaryColor,
                          size: 15,
                        ),
                        title: Text(e, style: themeData.textTheme.bodyText1),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
