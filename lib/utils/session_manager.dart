import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show window;

class SessionManager {
  static const String _keyName = 'doemais_user_id';
  static User _currentUser;

  static get currentUser => _currentUser;
  static get isLogged => currentUser != null;

  // Create local session
  static Future<void> createSession(User user, bool saveSession) async {
    _currentUser = user;
    if (kIsWeb) window.sessionStorage[_keyName] = '${user.id}';

    if (saveSession) await _saveLocal(user);
  }

  // Retrieve stored session
  static Future<void> retrieveLocal() async {
    String id;

    if (!kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getInt(_keyName).toString();
    } else
      id = window.localStorage[_keyName];

    if (id == null) return;

    _currentUser = await UserDao.getUser(id);
  }

  // End local session
  static void endSession() async {
    _currentUser = null;

    if (kIsWeb) window.sessionStorage[_keyName] = null;
  }

  // Delete stored session
  static Future<void> deleteLocal() async {
    if (!kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(_keyName);
    } else
      window.localStorage[_keyName] = null;
  }

  // Store local session
  static Future<void> _saveLocal(User user) async {
    if (!kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(_keyName, user.id);
    } else
      window.localStorage[_keyName] = '${user.id}';
  }
}
