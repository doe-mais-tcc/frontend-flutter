import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onPressed;
  CustomElevatedButton({this.icon, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon : Container(),
            Text('$label'.toUpperCase()),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
