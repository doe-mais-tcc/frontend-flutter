import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:doe_mais/components/horizontal_menu.dart';
import 'package:doe_mais/components/user_tile.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.only(bottom: 200),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                  alignment: Alignment.centerLeft,
                ),
                Spacer(),
                HorizontalMenu(currentIndex: currentIndex),
                UserTile(
                  onConfirm: () => messageBottomSheet(
                    context: context,
                    message: 'Usuário desconectado',
                    timeLimit: 3,
                  ),
                ),
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
        title: Image.asset(
          'assets/images/logo.png',
          height: 80,
        ),
      ),
      drawer: HamburgerMenu(
        currentIndex: currentIndex,
        onUserExit: () => messageBottomSheet(
          context: context,
          message: 'Usuário desconectado',
          timeLimit: 3,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 200),
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
