import 'dart:convert';
import 'package:http/http.dart' as http;

class DAL {
  static const String connectionString = 'localhost:8080';

  static Future<http.Response> get(String url) =>
      http.get(Uri.http(connectionString, url));

  static Future<http.Response> post(String url, {Object body}) => http.post(
        Uri.http(connectionString, url),
        body: body,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
      );

  static String encode(String input) {
    return base64.encode(utf8.encode(input));
  }

  static String decode(String input) {
    return utf8.decode(base64.decode(input));
  }
}
