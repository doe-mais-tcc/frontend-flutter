import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/screens/campanha_info.dart';
import 'package:doe_mais/screens/inicio.dart';
import 'package:flutter/material.dart';

enum Pages { Inicio, Duvidas, Campanhas, Perfil }

class Navigation {
  static const titles = [
    'Inicio',
    'Tire suas dúvidas',
    'Campanhas',
    'Perfil',
  ];

  static const routes = [
    '/inicio',
    '/duvidas',
    '/campanhas',
    '/perfil',
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
