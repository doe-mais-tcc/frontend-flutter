import 'dart:convert';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/dal.dart';

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

  static List<User> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<User>((e) => User.fromJson(e))
        .toList();
  }
}
