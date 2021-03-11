import 'package:doe_mais/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class HamburgerButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool isActive;
  HamburgerButton({
    @required this.label,
    @required this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).hoverColor,
                border: Border(
                  right: BorderSide(
                    width: 4,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : BoxDecoration(
                color: Colors.transparent,
              ),
        padding: const EdgeInsets.all(15),
        child: Text(
          label,
          style: isActive
              ? CustomTheme.activeHamburger(context)
              : CustomTheme.inactiveHamburger(context),
        ),
      ),
      onTap: onPressed,
    );
  }
}
