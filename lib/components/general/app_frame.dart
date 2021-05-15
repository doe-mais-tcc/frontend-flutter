import 'package:doe_mais/components/general/hamburger_menu.dart';
import 'package:doe_mais/components/general/horizontal_menu.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/navigation.dart' show Pages;
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class AppFrame extends StatelessWidget {
  final Widget child;
  final Pages page;
  final bool shrink;
  AppFrame({
    this.child,
    this.page,
    this.shrink = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < 750
            ? NarrowLayout(child, page.index, shrink)
            : BroadLayout(child, page.index, shrink);
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
            Material(
              shadowColor: Colors.black26,
              elevation: 8,
              child: Padding(
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
            ),
            Expanded(
              child: shrink
                  ? Padding(
                      padding: const EdgeInsets.only(
                          right: 70, left: 70, bottom: 50),
                      child: screen,
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.only(
                          right: 70, left: 70, bottom: 200),
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
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: screen,
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 200),
              child: screen,
            ),
    );
  }
}
