import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/screens/campanha_info.dart';
import 'package:doe_mais/screens/inicio.dart';
import 'package:flutter/material.dart';

class Navigation {
  static const titles = [
    'Inicio',
    'Perfil',
    'Tire suas dúvidas',
    'Campanhas',
  ];

  static const routes = [
    '/home',
    '/perfil',
    '/duvidas',
    '/campanhas',
  ];

  static String getCampanhaRoute(Campanha campanha) {
    var uriId = Campanha.uriEncode(campanha);
    var uri = Uri(
      path: '/campanhas/campanha',
      queryParameters: {'id': uriId},
    );
    return uri.toString();
  }

  static Route<dynamic> generateRoutes(RouteSettings route) {
    var uri = Uri.parse(route.name);
    if (uri.path == '/campanhas/campanha') {
      //Get campanha id from uri id
      var uriId = uri.queryParameters['id'];
      var id = Campanha.uriDecode(uriId);

      return MaterialPageRoute(
        builder: (context) => CampanhaInfo(id),
        settings: route,
      );
    }

    return MaterialPageRoute(builder: (context) => Inicio());
  }
}
