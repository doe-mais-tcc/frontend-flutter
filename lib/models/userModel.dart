import 'package:intl/intl.dart';

class UserModel {
  int id;
  String nome;
  String email;
  String senha;
  String cidade;
  String sangue;
  DateTime nascimento;

  UserModel({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.cidade,
    this.sangue,
    this.nascimento,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      cidade: json['cidade'],
      sangue: json['sangue'],
      nascimento: DateFormat('dd-MM-yyyy').parse(json['nascimento']),
    );
  }
}
