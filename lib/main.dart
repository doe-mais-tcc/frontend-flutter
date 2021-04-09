import 'package:doe_mais/screens/campanha_form.dart';
import 'package:doe_mais/screens/campanhas.dart';
import 'package:doe_mais/screens/donation_info.dart';
import 'package:doe_mais/screens/faq.dart';
import 'package:doe_mais/screens/home.dart';
import 'package:doe_mais/screens/login.dart';
import 'package:doe_mais/screens/profile.dart';
import 'package:doe_mais/screens/signup.dart';
import 'package:doe_mais/utils/main_theme.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(DoeMais());
  SessionManager.returnSession();
}

class DoeMais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      theme: mainTheme(),
      initialRoute: '/home',
      onUnknownRoute: (routeSettings) =>
          MaterialPageRoute(builder: (context) => Home()),
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Home(),
        '/perfil': (context) =>
            SessionManager.currentUser == null ? Login() : Profile(),
        '/duvidas': (context) => FAQ(),
        '/campanhas': (context) => Campanhas(),
        '/requisitos-doacao': (context) => DonationInfo(),
        '/campanhas/criar': (context) =>
            SessionManager.currentUser == null ? Login() : CampanhaForm(),
      },
    );
  }
}
