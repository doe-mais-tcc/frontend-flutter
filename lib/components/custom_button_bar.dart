import 'package:flutter/material.dart';

class CustomButtonBar extends StatelessWidget {
  final List<Widget> buttons;
  const CustomButtonBar({@required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buttons
          .map(
            (e) => Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}
