import 'package:intl/intl.dart';

class User {
  int id;
  String nome;
  String email;
  String senha;
  String cidade;
  String sangue;
  DateTime nascimento;
  String sexo;
  int pontuacao;

  User({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.cidade,
    this.sangue,
    this.nascimento,
    this.sexo,
    this.pontuacao,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        nome: json['nome'],
        email: json['email'],
        senha: json['senha'],
        cidade: json['cidade'],
        sangue: json['tipo_sanguineo'],
        nascimento: json['data_nascimento'] != null
            ? DateFormat('dd-MM-yyyy').parse(json['data_nascimento'])
            : null,
        sexo: json['sexo'],
        pontuacao: json['pontuacao'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'nome': this.nome,
        'email': this.email,
        'senha': this.senha,
        'cidade': this.cidade,
        'tipo_sanguineo': this.sangue,
        'data_nascimento': this.nascimento != null
            ? DateFormat('dd-MM-yyyy').format(this.nascimento)
            : null,
        'sexo': this.sexo,
        'pontuacao': this.pontuacao,
      };

  // Replace non null parameters from object
  inject(User user) {
    this.id = user.id ?? this.id;
    this.nome = user.nome ?? this.nome;
    this.nome = user.nome ?? this.nome;
    this.email = user.email ?? this.email;
    this.senha = user.senha ?? this.senha;
    this.cidade = user.cidade ?? this.cidade;
    this.sangue = user.sangue ?? this.sangue;
    this.nascimento = user.nascimento ?? this.nascimento;
    this.sexo = user.sexo ?? this.sexo;
    this.pontuacao = user.pontuacao ?? this.pontuacao;
  }
}
