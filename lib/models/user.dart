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

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        nome: json['nome'],
        email: json['email'],
        senha: json['senha'],
        cidade: json['cidade'],
        sangue: json['sangue'],
        nascimento: json['nascimento'] != null
            ? DateFormat('dd-MM-yyyy').parse(json['nascimento'])
            : null,
        qtdDoacao: json['quantidadeDoacao'],
        ultimaDoacao: json['ultimaDoacao'] != null
            ? DateFormat('dd-MM-yyyy').parse(json['ultima_doacao'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'nome': this.nome,
        'email': this.email,
        'senha': this.senha,
        'cidade': this.cidade,
        'sangue': this.sangue,
        'nascimento': this.nascimento != null
            ? DateFormat('dd-MM-yyyy').format(this.nascimento)
            : null,
        'quantidadeDoacao': this.qtdDoacao,
        'ultimaDoacao': this.ultimaDoacao,
      };
}
