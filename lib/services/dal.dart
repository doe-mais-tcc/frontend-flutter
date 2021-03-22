import 'dart:convert';
import 'package:doe_mais/models/user.dart';
import 'package:http/http.dart' as http;

class DAL {
  Future<List<User>> fetchUsers() {
    return http
        .get(Uri.http('54.207.234.58:8080', '/v1/api/user'))
        .then((response) {
      if (response.statusCode == 200) return toList(response.body);
      throw Exception(response.statusCode);
    });
  }

  Future<dynamic> postUser(User user) {
    http
        .post(Uri.http('54.207.234.58:8080', '/v1/api/user'),
            body: jsonEncode(user))
        .then((response) {
      if (response.statusCode == 200) return true;
      throw Exception(response.statusCode);
    });
  }

  List<User> toList(String response) {
    return (jsonDecode(response) as List)
        .map<User>((e) => User.fromJson(e))
        .toList();
  }
}
