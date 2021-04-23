import 'dart:async';
import 'dart:convert';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/dal.dart';

class CampanhaDao {
  static Future<List<Campanha>> getCampanhas() {
    return DAL.get('v1/api/campanha').then(
      (response) {
        if (response.statusCode != 200)
          throw Exception(response.statusCode);
        else
          return _toList(utf8.decode(response.bodyBytes));
      },
    ).onError(
      (error, stackTrace) {
        print('$error');
        return null;
      },
    );
  }

  static Future<dynamic> postCampanha(Campanha campanha) {
    var map = campanha.toJson();
    map.remove('id');
    return DAL
        .post(
      'v1/api/campanha',
      body: jsonEncode(map),
    )
        .then(
      (response) {
        if (response.statusCode != 200)
          throw Exception(response.statusCode);
        else
          return true;
      },
    ).onError(
      (error, stackTrace) {
        print('$error');
        return null;
      },
    );
  }

  static List<Campanha> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<Campanha>((e) => Campanha.fromJson(e))
        .toList();
  }
}
