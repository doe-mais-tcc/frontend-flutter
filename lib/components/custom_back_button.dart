import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color buttonColor = Theme.of(context).indicatorColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            primary: buttonColor,
            textStyle: TextStyle(
              color: buttonColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
            child: Row(
              children: [
                Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: buttonColor,
                ),
                Text('Voltar'),
              ],
            ),
          ),
          onPressed: () {
            var navigator = Navigator.of(context);
            if (navigator.canPop()) navigator.pop();
            navigator.pushNamed('/home');
          },
        ),
      ],
    );
  }
}
