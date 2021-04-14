import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as kIsWeb;

class SessionManager {
  static const String _keyName = 'user_id';
  static User currentUser;

  static void saveSession(User user) async {
    currentUser = user;
    if (!kIsWeb.kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(_keyName, user.id);
    }
  }

  static Future<dynamic> getSession() async {
    if (!kIsWeb.kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt(_keyName);
      return id;
    }
  }

  static void endSession() async {
    if (!kIsWeb.kIsWeb) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(_keyName);
    }
    currentUser = null;
  }

  static void returnSession() async {
    var id = await getSession();
    if (id == null) return;

    currentUser = await UserDao.getUser('$id');
  }
}
