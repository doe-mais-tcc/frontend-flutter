import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class DAL {
  static const String connectionString =
      kIsWeb ? 'localhost:8080' : '10.0.2.2:8080';
  static const _header = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  static Future<http.Response> get(String url) async {
    var response = await http
        .get(
      Uri.http(connectionString, url),
      headers: _header,
    )
        //Handle get error
        .onError(
      (error, stackTrace) {
        print('[ERROR] $error: $stackTrace');
        throw error;
      },
      //Get timeout
    ).timeout(
      Duration(minutes: 2),
      onTimeout: () {
        print('[TIMEOUT] http get hit time out');
        return null;
      },
    );
    if (!_handleResponse(response))
      throw Exception('[ERROR]: Null response on get');

    //Returned response is never null
    return response;
  }

  static Future<http.Response> post(String url, {Object body}) async {
    var response = await http
        .post(
      Uri.http(connectionString, url),
      body: body,
      headers: _header,
      //Handle error
    )
        .onError(
      (error, stackTrace) {
        print('[ERROR] $error: $stackTrace');
        throw error;
      },
      //Post timeout
    ).timeout(
      Duration(minutes: 2),
      onTimeout: () {
        print('[TIMEOUT] http set hit time out');
        return null;
      },
    );
    if (!_handleResponse(response))
      throw Exception('[ERROR]: Null response on set');

    //Returned response is never null
    return response;
  }

  static Future<http.Response> delete(String url) async {
    var response = await http
        .delete(
      Uri.http(connectionString, url),
      headers: _header,
      //Handle error
    )
        .onError(
      (error, stackTrace) {
        print('[ERROR] $error: $stackTrace');
        throw error;
      },
      //Post timeout
    ).timeout(
      Duration(minutes: 2),
      onTimeout: () {
        print('[TIMEOUT] http delete hit time out');
        return null;
      },
    );
    if (!_handleResponse(response))
      throw Exception('[ERROR]: Null response on delete');

    //Returned response is never null
    return response;
  }

  static Future<http.Response> update(String url, {Object body}) async {
    var response = await http
        .put(
      Uri.http(connectionString, url),
      body: body,
      headers: _header,
      //Handle error
    )
        .onError(
      (error, stackTrace) {
        print('[ERROR] $error: $stackTrace');
        throw error;
      },
      //Post timeout
    ).timeout(
      Duration(minutes: 2),
      onTimeout: () {
        print('[TIMEOUT] http put hit time out');
        return null;
      },
    );
    if (!_handleResponse(response))
      throw Exception('[ERROR]: Null response on put');

    //Returned response is never null
    return response;
  }

  static String encode(String input) {
    return base64.encode(utf8.encode(input));
  }

  static String decode(String input) {
    return utf8.decode(base64.decode(input));
  }

  static bool _handleResponse(http.Response response) {
    if (response == null) return false;
    if (response.statusCode != 200) return false;
    return true;
  }
}
