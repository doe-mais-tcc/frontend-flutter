import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ConfirmationCard extends StatelessWidget {
  final String title;
  final String description;
  final String confirmMessage;
  final Function onConfirm;
  final Widget icon;
  ConfirmationCard({
    @required this.title,
    @required this.description,
    @required this.confirmMessage,
    @required this.onConfirm,
    @required this.icon,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/icon_background.png', width: 120),
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
            CustomElevatedButton(
              label: confirmMessage,
              onPressed: onConfirm,
            ),
          ],
        ),
      ),
    );
  }
}
