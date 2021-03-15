import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset('assets/images/logo.svg')),
      drawer: HamburgerMenu(currentIndex: 2),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Text('Tire suas Dúvidas!',
              style: Theme.of(context).textTheme.headline1),
        ],
      ),
    );
  }
}
