import 'package:doe_mais/screens/home.dart';
import 'package:doe_mais/screens/login.dart';
import 'package:doe_mais/screens/signup.dart';
import 'package:doe_mais/utils/main_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DoeMais());
}

class DoeMais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainTheme(),
      initialRoute: '/home',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Home(),
      },
    );
  }
}
