import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Icon leftIcon;
  final Icon rightIcon;
  final String label;
  final Function onPressed;
  CustomElevatedButton({
    this.leftIcon,
    this.rightIcon,
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leftIcon ?? Container(),
            Text('$label'.toUpperCase()),
            rightIcon ?? Container(),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
