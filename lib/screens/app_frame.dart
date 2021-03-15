import 'package:doe_mais/components/hamburger_button.dart';
import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppFrame extends StatefulWidget {
  static Widget widget;

  @override
  _AppFrameState createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        if (constrains.maxWidth > 700)
          return BroadLayout();
        else
          return NarrowLayout();
      },
    );
  }
}

class BroadLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 100,
                ),
                Spacer(),
                HamburgerButton(
                  label: 'Inicio',
                  onPressed: () {},
                ),
                HamburgerButton(
                  label: 'Perfil',
                  onPressed: () {},
                ),
                HamburgerButton(
                  label: 'Dúvidas',
                  onPressed: () {},
                ),
                HamburgerButton(
                  label: 'Campanhas',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: AppFrame.widget,
          )),
        ],
      ),
    );
  }
}

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/logo.svg'),
      ),
      drawer: HamburgerMenu(currentIndex: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AppFrame.widget,
      ),
    );
  }
}
