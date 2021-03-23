import 'dart:convert';
import 'package:doe_mais/models/user.dart';
import 'package:http/http.dart' as http;

class DAL {
  // Conection string
  static const String url = 'localhost:8080';

  // DAL singleton
  static DAL _database;
  static DAL get database {
    if (_database == null) _database = DAL();
    return _database;
  }

  Future<List<User>> fetchUsers() {
    return http.get(Uri.http(url, 'v1/api/user')).then(
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

  Future<dynamic> postUser(User user) {
    return http.post(
      Uri.http(url, 'v1/api/user'),
      body: jsonEncode(user.toJson()),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    ).then(
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

  Future<bool> checkUser(User user) {
    return http.get(Uri.http(url, 'v1/api/user/email/${user.email}')).then(
      (response) {
        if (response.statusCode != 200) throw Exception(response.statusCode);
        if (response.body.length == 0) throw Exception('No such user');

        User responseUser = User.fromJson(jsonDecode(response.body));
        return responseUser.senha == _base64Encode(user.senha);
      },
    ).onError(
      (error, stackTrace) => throw Exception(error),
    );
  }

  List<User> _toList(String response) {
    return (jsonDecode(response) as List)
        .map<User>((e) => User.fromJson(e))
        .toList();
  }

  String _base64Encode(String input) {
    return base64.encode(utf8.encode(input));
  }

  String _base64Decode(String input) {
    return utf8.decode(base64.decode(input));
  }
}
