import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Map<String, dynamic> json;
  InfoCard(this.json);

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
                '${json['title']}',
                style: themeData.textTheme.headline2,
              ),
            ),
            Column(
              children: (json['items'] as List)
                  .map((e) => ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          color: themeData.primaryColor,
                          size: 15,
                        ),
                        title: Text('$e', style: themeData.textTheme.bodyText1),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
