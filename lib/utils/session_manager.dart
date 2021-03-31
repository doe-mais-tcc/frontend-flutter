import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static User currentUser;

  static void saveSession(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', user.id);
    currentUser = user;
  }

  static Future<dynamic> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('user_id');
    return id;
  }

  static void endSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    currentUser = null;
  }

  static void returnSession() async {
    var id = await getSession();
    if (id == null) return;

    currentUser = await UserDao.getUser('$id');
  }
}
