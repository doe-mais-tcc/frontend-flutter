import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/components/custom_outlined_button.dart';
import 'package:flutter/material.dart';

Future<bool> confirmDialog({
  @required BuildContext context,
  String message,
  String yesLabel,
  String noLabel,
  Function yesAction,
  Function noAction,
}) async {
  return await showDialog(
    context: context,
    useSafeArea: true,
    barrierColor: Colors.black.withAlpha(180),
    builder: (context) => Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$message',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Flexible(
                    child: CustomOutlinedButton(
                      label: noLabel,
                      onPressed: noAction,
                    ),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    child: CustomElevatedButton(
                      label: yesLabel,
                      onPressed: yesAction,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
