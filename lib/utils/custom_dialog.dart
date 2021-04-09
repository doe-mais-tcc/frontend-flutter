import 'package:flutter/material.dart';

Future<dynamic> customDialog({
  @required BuildContext context,
  String title,
  String message,
  Widget primaryButton,
  Widget secondaryButton,
}) {
  ThemeData theme = Theme.of(context);
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    barrierColor: Colors.black.withAlpha(180),
    builder: (context) => Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450, minHeight: 450),
        child: Card(
          margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    message,
                    style: theme.textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      Flexible(
                        flex: 1,
                        child: secondaryButton,
                      ),
                      Flexible(
                        flex: 1,
                        child: primaryButton,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
