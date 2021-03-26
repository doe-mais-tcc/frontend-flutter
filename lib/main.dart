import 'package:doe_mais/screens/campaign_form.dart';
import 'package:doe_mais/screens/campaigns.dart';
import 'package:doe_mais/screens/donation_info.dart';
import 'package:doe_mais/screens/faq.dart';
import 'package:doe_mais/screens/home.dart';
import 'package:doe_mais/screens/login.dart';
import 'package:doe_mais/screens/profile.dart';
import 'package:doe_mais/screens/signup.dart';
import 'package:doe_mais/utils/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(DoeMais());
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Home(),
        '/perfil': (context) => Profile(),
        '/duvidas': (context) => FAQ(),
        '/campanhas': (context) => Campaigns(),
        '/perfil/requisitos-doacao': (context) => DonationInfo(),
        '/campanhas/criar': (context) => CampaignForm(),
      },
    );
  }
}
