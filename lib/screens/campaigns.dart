import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Campaigns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset('assets/images/logo.svg')),
      drawer: HamburgerMenu(currentIndex: 3),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Text('Campanhas', style: Theme.of(context).textTheme.headline1),
        ],
      ),
    );
  }
}
