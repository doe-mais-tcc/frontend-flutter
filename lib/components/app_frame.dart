import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:doe_mais/components/horizontal_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppFrame extends StatefulWidget {
  final Widget child;
  final int menuIndex;
  AppFrame({this.child, this.menuIndex});

  @override
  _AppFrameState createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700)
          return BroadLayout(widget.child, widget.menuIndex);
        else
          return NarrowLayout(widget.child, widget.menuIndex);
      },
    );
  }
}

class BroadLayout extends StatelessWidget {
  final Widget screen;
  final int currentIndex;
  BroadLayout(this.screen, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 100,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                HorizontalMenu(currentIndex: currentIndex),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: screen,
          ),
        ],
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  final Widget screen;
  final int currentIndex;
  NarrowLayout(this.screen, this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/logo.svg'),
      ),
      drawer: HamburgerMenu(currentIndex: currentIndex),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: screen,
          ),
        ],
      ),
    );
  }
}
