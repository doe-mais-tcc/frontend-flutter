import 'package:doe_mais/components/menu_button.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HamburgerMenu extends StatelessWidget {
  final int currentIndex;
  HamburgerMenu({this.currentIndex});

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
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: 18,
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
