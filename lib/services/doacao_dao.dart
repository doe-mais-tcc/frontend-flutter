import 'dart:async';
import 'dart:convert';
import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/dal.dart';

class DoacaoDao {
  static const String _baseUrl = 'v1/api/doacao';

  static Future<List<Doacao>> getDoacao(User user) async {
    var response = await DAL.get('$_baseUrl/recuperar/${user.id}');
    return _toList(utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> postDoacao(Doacao doacao) async {
    var map = doacao.toJson();
    var response = await DAL.post(
      '$_baseUrl/criar',
      body: jsonEncode(map),
    );
    return response;
  }

  static List<Doacao> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<Doacao>((e) => Doacao.fromJson(e))
        .toList();
  }
}
