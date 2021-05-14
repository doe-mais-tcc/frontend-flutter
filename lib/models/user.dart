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
}
