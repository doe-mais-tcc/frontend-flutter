import 'package:intl/intl.dart';

enum Sexo { Masculino, Feminino }

class User {
  int id;
  String nome;
  String email;
  String senha;
  String cidade;
  String sangue;
  DateTime nascimento;
  Sexo sexo;

  User({
    this.id,
    this.nome,
    this.email,
    this.senha,
    this.cidade,
    this.sangue,
    this.nascimento,
    this.sexo,
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
        sexo: json['sexo'] == 'M' ? Sexo.Masculino : Sexo.Feminino,
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
        'sexo': this.sexo == Sexo.Masculino ? 'M' : 'F',
      };
}
