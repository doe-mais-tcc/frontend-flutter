import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:doe_mais/components/horizontal_menu.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class AppFrame extends StatefulWidget {
  final Widget child;
  final int menuIndex;
  final bool shrink;
  AppFrame({
    this.child,
    this.menuIndex,
    this.shrink = false,
  });

  @override
  _AppFrameState createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700)
          return BroadLayout(widget.child, widget.menuIndex, widget.shrink);
        else
          return NarrowLayout(widget.child, widget.menuIndex, widget.shrink);
      },
    );
  }
}

class BroadLayout extends StatelessWidget {
  final Widget screen;
  final int currentIndex;
  final bool shrink;
  BroadLayout(this.screen, this.currentIndex, this.shrink);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 65,
                    width: 90,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  Expanded(
                    child: HorizontalMenu(currentIndex: currentIndex),
                  ),
                ],
              ),
            ),
            Expanded(
              child: shrink
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                      child: screen,
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(70, 20, 70, 200),
                      child: screen,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  final Widget screen;
  final int currentIndex;
  final bool shrink;
  NarrowLayout(this.screen, this.currentIndex, this.shrink);

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
        onUserExit: () {
          SessionManager.endSession();
          messageBottomSheet(
            context: context,
            message: 'Usuário desconectado',
            timeLimit: 3,
          );
        },
      ),
      body: shrink
          ? Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
              child: screen,
            )
          : SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 200),
              child: screen,
            ),
    );
  }
}
