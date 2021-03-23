import 'dart:convert';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/dal.dart';

class UserDao {
  static Future<List<User>> fetchUsers() {
    return DAL.get('v1/api/user').then(
      (response) {
        if (response.statusCode != 200)
          throw Exception(response.statusCode);
        else
          return _toList(response.body);
      },
    ).onError(
      (error, stackTrace) => null,
    );
  }

  static Future<dynamic> postUser(User user) {
    return DAL
        .post(
      'v1/api/user',
      body: jsonEncode(user.toJson()),
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

  static Future<bool> checkUser(User user) {
    return DAL.get('v1/api/user/email/${user.email}').then(
      (response) {
        if (response.statusCode != 200) throw Exception(response.statusCode);
        if (response.body.length == 0) throw Exception('No such user');

        User responseUser = User.fromJson(jsonDecode(response.body));
        return responseUser.senha == DAL.encode(user.senha);
      },
    ).onError(
      (error, stackTrace) => throw Exception(error),
    );
  }

  static List<User> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<User>((e) => User.fromJson(e))
        .toList();
  }
}
