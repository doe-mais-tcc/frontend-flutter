import 'package:intl/intl.dart';

class UserModel {
  int id;
  String name;
  String email;
  String password;
  String city;
  String blood;
  DateTime birthDate;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.city,
    this.blood,
    this.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['nome'],
      email: json['email'],
      password: json['senha'],
      city: json['cidade'],
      blood: json['sangue'],
      birthDate: DateFormat('dd-MM-yyyy').parse(json['nascimento']),
    );
  }
}
