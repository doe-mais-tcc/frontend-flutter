import 'dart:convert';

import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/dal.dart';

class HemocentroDao {
  static Future<List<Hemocentro>> getHemocentros() {
    return DAL.get('v1/api/hemocentro').then(
      (response) {
        if (response.statusCode != 200)
          throw Exception(response.statusCode);
        else
          return _toList(utf8.decode(response.bodyBytes));
      },
    ).onError(
      (error, stackTrace) => null,
    );
  }

  static Future<dynamic> postHemocentro(Hemocentro hemocentro) {
    return DAL
        .post(
      'v1/api/hemocentro',
      body: jsonEncode(hemocentro.toJson()),
    )
        .then(
      (response) {
        if (response.statusCode != 200)
          throw Exception(response.statusCode);
        else
          return true;
      },
    ).onError(
      (error, stackTrace) => null,
    );
  }

  static List<Hemocentro> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<Hemocentro>((e) => Hemocentro.fromJson(e))
        .toList();
  }
}
