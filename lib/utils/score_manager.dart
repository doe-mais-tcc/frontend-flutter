import 'dart:convert';

import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/services.dart';

class ScoreManager {
  static double get percentage {
    User user = SessionManager.currentUser;
    if (user == null) return 0;
    return user.pontuacao % 10 / 10;
  }

  static int get level {
    User user = SessionManager.currentUser;
    if (user == null) return 0;
    return user.pontuacao ~/ 10;
  }

  static int get points {
    User user = SessionManager.currentUser;
    if (user == null) return 0;
    return user.pontuacao % 10;
  }

  static Future<List<String>> getMisisons() async {
    var data = await rootBundle.loadString('files/score_missions.json');
    var map = jsonDecode(data);
    var items = (map['texts'] as List)..shuffle();

    return items.cast<String>();
  }

  static void addScore(int qty) {
    User user = SessionManager.currentUser;
    if (user == null) return;

    user.pontuacao += qty;
    UserDao.updateUser(user);
  }
}
