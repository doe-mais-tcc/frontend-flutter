import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  final String title;
  final String content;
  final String submitLabel;
  const Modal({
    @required this.title,
    @required this.content,
    @required this.submitLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Text(title, style: Theme.of(context).textTheme.headline1),
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(content),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: CustomElevatedButton(
                label: submitLabel,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
