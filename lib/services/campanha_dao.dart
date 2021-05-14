import 'dart:async';
import 'dart:convert';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/dal.dart';

class CampanhaDao {
  static const String _baseUrl = 'v1/api/campanha';

  static Future<List<Campanha>> getCampanhas() async {
    var response = await DAL.get('$_baseUrl/recuperar');
    return _toList(utf8.decode(response.bodyBytes));
  }

  static Future<Campanha> getCampanha(String id) async {
    var response = await DAL.get('$_baseUrl/recuperar/$id');
    var json = utf8.decode(response.bodyBytes);
    return Campanha.fromJson(jsonDecode(json));
  }

  static Future<dynamic> postCampanha(Campanha campanha) async {
    var map = campanha.toJson();
    map.remove('id');

    var response = await DAL.post(
      '$_baseUrl/criar',
      body: jsonEncode(map),
    );
    return response;
  }

  static Future<void> deleteCampanha(Campanha campanha) async {
    return await DAL.delete('$_baseUrl/deletar/${campanha.id}');
  }

  static List<Campanha> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<Campanha>((e) => Campanha.fromJson(e))
        .toList();
  }
}
