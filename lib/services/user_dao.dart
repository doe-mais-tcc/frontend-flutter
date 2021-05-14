import 'dart:convert';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/services/dal.dart';
import 'package:doe_mais/services/doacao_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';

class UserDao {
  static const String _baseUrl = 'v1/api/usuario';

  static Future<List<User>> fetchUsers() async {
    var response = await DAL.get('$_baseUrl/recuperar');
    return _toList(utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> postUser(User user) async {
    var response = await DAL.post(
      'v1/api/usuario/criar',
      body: jsonEncode(user.toJson()),
    );
    return response;
  }

  static Future<User> checkUser(User user) async {
    var response = await DAL.get('$_baseUrl/recuperar/email/${user.email}');

    if (response.body.length == 0) throw Exception('No such user');

    User responseUser = User.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)),
    );

    if (responseUser.senha == DAL.encode(user.senha))
      return responseUser;
    else
      return null;
  }

  static Future<User> getUser(String id) async {
    var response = await DAL.get('$_baseUrl/recuperar/$id');

    if (response.body.length == 0) throw Exception('No such user');

    return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  static Future<void> deleteUser(User user) async {
    SessionManager.endSession();

    //Delete user's donations
    var doacao = await DoacaoDao.getDoacaoUser(user);
    if (doacao != null) await DoacaoDao.deleteDoacao(doacao);

    //Delete user's campaigns
    var campanhas = await CampanhaDao.getCampanhas();
    var userCampanhas = campanhas.where((e) => e.user.id == user.id);
    for (var camp in userCampanhas) await CampanhaDao.deleteCampanha(camp);

    //Delete user
    return await DAL.delete('$_baseUrl/deletar/${user.id}');
  }

  static Future<void> updateUser(User user) async {
    return await DAL.update(
      '$_baseUrl/atualizar/${user.id}',
      body: jsonEncode(user.toJson()),
    );
  }

  static List<User> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<User>((e) => User.fromJson(e))
        .toList();
  }
}
