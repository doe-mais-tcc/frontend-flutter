import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
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
          TextButton(
            child: Text('Inicio'),
            onPressed: () {},
          ),
          TextButton(
            child: Text('Perfil'),
            onPressed: () {},
          ),
          TextButton(
            child: Text('Tire Dúvidas'),
            onPressed: () {},
          ),
          TextButton(
            child: Text('Campanhas'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
