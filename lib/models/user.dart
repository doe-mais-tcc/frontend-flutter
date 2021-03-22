import 'package:intl/intl.dart';

class User {
  int id;
  String nome;
  String email;
  String senha;
  String cidade;
  String sangue;
  DateTime nascimento;
  int qtdDoacao;
  DateTime ultimaDoacao;

  User({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.cidade,
    this.sangue,
    this.nascimento,
    this.qtdDoacao,
    this.ultimaDoacao,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      cidade: json['cidade'],
      sangue: json['sangue'],
      nascimento: DateFormat('dd-MM-yyyy').parse(json['nascimento']),
      qtdDoacao: json['quantidade_doacao'],
      ultimaDoacao: DateFormat('dd-MM-yyyy').parse(json['ultima_doacao']),
    );
  }
}
