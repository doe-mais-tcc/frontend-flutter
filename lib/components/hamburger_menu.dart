import 'package:doe_mais/components/menu_button.dart';
import 'package:doe_mais/components/user_tile.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  final int currentIndex;
  final Function onUserExit;
  HamburgerMenu({this.currentIndex, this.onUserExit});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Text(
                  'Menu',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: UserTile(
                    onConfirm: () {
                      Navigator.pop(context);
                      onUserExit();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Navigation.routes.length,
              itemBuilder: (context, index) {
                return MenuButton(
                  label: Navigation.titles[index],
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Navigation.routes[index]),
                  isActive: currentIndex == index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
