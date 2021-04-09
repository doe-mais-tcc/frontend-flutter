import 'package:flutter/material.dart';

Future<dynamic> alertBottomSheet(
    {@required BuildContext context, String message, int timeLimit}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => _customBottomSheet(
        context,
        Text(
          '$message',
          style: TextStyle(color: Colors.white),
        )),
    backgroundColor: Theme.of(context).primaryColor,
    barrierColor: Colors.black.withAlpha(50),
  ).timeout(
    Duration(seconds: timeLimit ?? 10),
    onTimeout: () => Navigator.of(context).pop(),
  );
}

Future<dynamic> messageBottomSheet(
    {@required BuildContext context, String message, int timeLimit}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => _customBottomSheet(
        context,
        Text(
          '$message',
          style: TextStyle(color: Colors.white),
        )),
    backgroundColor: Theme.of(context).disabledColor,
    barrierColor: Colors.transparent,
    isDismissible: false,
  ).timeout(
    Duration(seconds: timeLimit ?? 10),
    onTimeout: () => Navigator.of(context).pop(),
  );
}

Widget _customBottomSheet(BuildContext context, Widget item) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        item,
        IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
          hoverColor: Colors.white.withAlpha(50),
          tooltip: 'Fechar mensagem',
        )
      ],
    ),
  );
}
