import 'package:doe_mais/screens/campanha_form.dart';
import 'package:doe_mais/screens/campanhas.dart';
import 'package:doe_mais/screens/requisitos_doacao.dart';
import 'package:doe_mais/screens/duvidas.dart';
import 'package:doe_mais/screens/inicio.dart';
import 'package:doe_mais/screens/login.dart';
import 'package:doe_mais/screens/perfil.dart';
import 'package:doe_mais/screens/signup.dart';
import 'package:doe_mais/utils/main_theme.dart';
import 'package:doe_mais/utils/navigation.dart';
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
      title: 'Doe+',
      theme: mainTheme(),
      initialRoute: '/home',
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Inicio(),
        '/perfil': (context) =>
            SessionManager.currentUser == null ? Login() : Perfil(),
        '/duvidas': (context) => Duvidas(),
        '/campanhas': (context) => Campanhas(),
        '/requisitos-doacao': (context) => RequisitosDoacao(),
        '/campanhas/criar': (context) =>
            SessionManager.currentUser == null ? Login() : CampanhaForm(),
      },
      onGenerateRoute: Navigation.generateRoutes,
    );
  }
}
