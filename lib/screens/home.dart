import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:doe_mais/screens/pages/campaigns.dart';
import 'package:doe_mais/screens/pages/dashboard.dart';
import 'package:doe_mais/screens/pages/faq.dart';
import 'package:doe_mais/screens/pages/profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pages = [
    Dashboard(),
    Profile(),
    FAQ(),
    Campaigns(),
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset('assets/images/logo.svg')),
      drawer: HamburgerMenu(
        currentIndex: currentPage,
        callback: (index) {
          setState(() => currentPage = index);
          Navigator.of(context).pop();
        },
      ),
      body: pages[currentPage],
    );
  }
}
