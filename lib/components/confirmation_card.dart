import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ConfirmationCard extends StatelessWidget {
  final String title;
  final String description;
  final String confirmMessage;
  final Function onConfirm;
  ConfirmationCard({
    @required this.title,
    @required this.description,
    @required this.confirmMessage,
    @required this.onConfirm,
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
            SizedBox(height: 70),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
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
