import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/models/user.dart';
import 'package:flutter/material.dart';

class Doacao {
  int id;
  DateTime data;
  TimeOfDay hora;
  User user;
  Hemocentro hemocentro;

  Doacao({
    this.id,
    this.data,
    this.hora,
    this.user,
    this.hemocentro,
  });
}
