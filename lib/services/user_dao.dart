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
          return _toList(utf8.decode(response.bodyBytes));
      },
    ).onError(
      (error, stackTrace) {
        print('$error');
        return null;
      },
    ).timeout(Duration(minutes: 1));
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
      (error, stackTrace) {
        print('$error');
        return null;
      },
    ).timeout(Duration(minutes: 1));
  }

  static Future<User> checkUser(User user) {
    return DAL.get('v1/api/user/email/${user.email}').then(
      (response) {
        if (response.statusCode != 200) throw Exception(response.statusCode);
        if (response.body.length == 0) throw Exception('No such user');

        User responseUser =
            User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        if (responseUser.senha == DAL.encode(user.senha))
          return responseUser;
        else
          return null;
      },
    ).onError(
      (error, stackTrace) {
        print('$error');
        return null;
      },
    ).timeout(Duration(minutes: 1));
  }

  static Future<User> getUser(String id) {
    return DAL.get('v1/api/user/$id').then((response) {
      if (response.statusCode != 200) throw Exception(response.statusCode);
      if (response.body.length == 0) throw Exception('No such user');

      return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }).onError(
      (error, stackTrace) {
        print('$error');
        return null;
      },
    ).timeout(Duration(minutes: 1));
  }

  static List<User> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<User>((e) => User.fromJson(e))
        .toList();
  }
}
