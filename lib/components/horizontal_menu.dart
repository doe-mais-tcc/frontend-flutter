import 'package:doe_mais/components/menu_button.dart';
import 'package:doe_mais/components/user_tile.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class HorizontalMenu extends StatelessWidget {
  final int currentIndex;
  HorizontalMenu({this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        Navigation.routes.length,
        (index) => MenuButton(
          label: Navigation.titles[index],
          onPressed: () =>
              Navigator.of(context).pushNamed(Navigation.routes[index]),
          isActive: currentIndex == index,
          isHorizontal: true,
        ),
      )..add(
          UserTile(
            onConfirm: () {
              SessionManager.endSession();
              Navigator.of(context).pushNamed('/home');
            },
          ),
        ),
    );
  }
}
