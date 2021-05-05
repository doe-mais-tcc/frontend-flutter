import 'dart:convert';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/dal.dart';

class HemocentroDao {
  static const String _baseUrl = 'v1/api/hemocentro';

  static Future<List<Hemocentro>> getHemocentros() async {
    var response = await DAL.get('$_baseUrl/recuperar');
    return _toList(utf8.decode(response.bodyBytes));
  }

  static Future<List<String>> getCidades() async {
    var hemocentros = await getHemocentros();
    List<String> cidades = [];
    for (int i = 0; i < hemocentros.length; i++) {
      if (!cidades.contains(hemocentros[i].cidade))
        cidades.add(hemocentros[i].cidade);
    }
    return cidades;
  }

  static List<Hemocentro> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<Hemocentro>((e) => Hemocentro.fromJson(e))
        .toList();
  }
}
