import 'package:doe_mais/screens/login.dart';
import 'package:doe_mais/screens/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DoeMais());
}

class DoeMais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => SignUp(),
      },
    );
  }
}
