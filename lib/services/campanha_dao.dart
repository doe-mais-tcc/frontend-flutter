import 'dart:async';
import 'dart:convert';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/dal.dart';

class CampanhaDao {
  static Future<List<Campanha>> getCampanhas() async {
    var response = await DAL.get('v1/api/campanha/recuperar');
    return _toList(utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> postCampanha(Campanha campanha) async {
    var map = campanha.toJson();
    map.remove('id');

    var response = await DAL.post(
      'v1/api/campanha/criar',
      body: jsonEncode(map),
    );
    return response;
  }

  static List<Campanha> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<Campanha>((e) => Campanha.fromJson(e))
        .toList();
  }
}
