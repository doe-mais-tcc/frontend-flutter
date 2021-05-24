import 'package:flutter/material.dart';

class ConfirmationCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget confirmWidget;
  final int fontSize;
  final Widget icon;
  final String info;
  ConfirmationCard({
    @required this.title,
    @required this.description,
    @required this.confirmWidget,
    this.icon,
    this.info,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: info != null
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 120,
                      height: 120,
                      child: Center(
                        child: Text(
                          info,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSize ?? 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/images/icon_background.png',
                            width: 120),
                        SizedBox(child: icon, width: 70),
                      ],
                    ),
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            confirmWidget,
          ],
        ),
      ),
    );
  }
}
