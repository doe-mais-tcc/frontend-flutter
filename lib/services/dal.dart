import 'dart:convert';
import 'package:doe_mais/models/userModel.dart';
import 'package:http/http.dart' as http;

class DAL {
  Future<List<UserModel>> fetchUsers() {
    return http
        .get(Uri.http('54.207.234.58:8080', '/v1/api/user'))
        .then((response) {
      if (response.statusCode == 200) return toList(response.body);
      throw Exception(response.statusCode);
    });
  }

  Future<dynamic> postUser(UserModel user) {
    http
        .post(Uri.http('54.207.234.58:8080', '/v1/api/user'),
            body: jsonEncode(user))
        .then((response) {
      if (response.statusCode == 200) return true;
      throw Exception(response.statusCode);
    });
  }

  List<UserModel> toList(String response) {
    return (jsonDecode(response) as List)
        .map<UserModel>((e) => UserModel.fromJson(e))
        .toList();
  }
}
