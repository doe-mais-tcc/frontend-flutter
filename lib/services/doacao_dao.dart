import 'dart:async';
import 'dart:convert';
import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/dal.dart';
import 'package:doe_mais/utils/session_manager.dart';

class DoacaoDao {
  static const String _baseUrl = 'v1/api/doacao';

  static Future<List<Doacao>> getDoacoes() async {
    var response = await DAL.get('$_baseUrl/recuperar/');
    return _toList(utf8.decode(response.bodyBytes));
  }

  static Future<Doacao> getDoacaoUser(User user) async {
    var doacoes = await getDoacoes();
    if (doacoes.isEmpty)
      return null;
    else
      return doacoes
          .firstWhere((e) => e.user.id == SessionManager.currentUser.id);
  }

  static Future<dynamic> postDoacao(Doacao doacao) async {
    var map = doacao.toJson();
    var response = await DAL.post(
      '$_baseUrl/criar',
      body: jsonEncode(map),
    );
    return response;
  }

  static Future<void> deleteDoacao(Doacao doacao) async {
    var map = doacao.toJson();
    await DAL.delete(
      '$_baseUrl/deletar/${doacao.id}',
      body: jsonEncode(map),
    );
    return null;
  }

  static List<Doacao> _toList(String response) {
    var aaaaaa = (jsonDecode(response) as List);
    return aaaaaa.map<Doacao>((e) => Doacao.fromJson(e)).toList();
  }
}
