import 'package:doe_mais/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool isActive;
  final bool isHorizontal;
  MenuButton({
    @required this.label,
    @required this.onPressed,
    this.isActive = false,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      child: Container(
        height: isHorizontal ? 65 : 50,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: !isActive
              ? Border()
              : isHorizontal
                  ? Border(
                      bottom: BorderSide(
                      width: 4,
                      color: theme.primaryColor,
                    ))
                  : Border(
                      right: BorderSide(
                      width: 4,
                      color: theme.primaryColor,
                    )),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: isActive
                ? CustomTheme.activeHamburger(context)
                : CustomTheme.inactiveHamburger(context),
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
