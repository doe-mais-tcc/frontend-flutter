import 'package:doe_mais/components/hamburger_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HamburgerMenu extends StatelessWidget {
  final Function(int) callback;
  final int currentIndex;
  HamburgerMenu({this.callback, this.currentIndex});

  final items = ['Inicio', 'Perfil', 'Tire suas Dúvidas', 'Campanhas'];

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
              itemCount: items.length,
              itemBuilder: (context, index) {
                return HamburgerButton(
                  label: items[index],
                  onPressed: () => callback(index),
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
