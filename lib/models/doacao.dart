import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/models/user.dart';
import 'package:intl/intl.dart';

class Doacao {
  int id;
  User user;
  DateTime ultimaDoacao;
  DateTime proximaDoacao;
  int quantidadeDoacao;
  Hemocentro hemocentro;

  Doacao({
    this.id,
    this.user,
    this.ultimaDoacao,
    this.proximaDoacao,
    this.quantidadeDoacao,
    this.hemocentro,
  });

  factory Doacao.fromJson(Map<String, dynamic> json) => Doacao(
        id: json['id'],
        user: User.fromJson(json['user']),
        ultimaDoacao: json['ultima_doacao'] != null
            ? DateFormat('dd-MM-yyyy').parse(json['ultima_doacao'])
            : null,
        proximaDoacao: json['proxima_doacao'] != null
            ? DateFormat('dd-MM-yyyy').parse(json['proxima_doacao'])
            : null,
        quantidadeDoacao: json['quantidade_doacao'],
        hemocentro: Hemocentro.fromJson(json['hemocentro']),
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'user': this.user.toJson(),
        'ultima_doacao': this.ultimaDoacao != null
            ? DateFormat('dd-MM-yyyy').format(this.ultimaDoacao)
            : null,
        'proxima_doacao': this.proximaDoacao != null
            ? DateFormat('dd-MM-yyyy').format(this.proximaDoacao)
            : null,
        'quantidade_doacao': this.quantidadeDoacao,
        'hemocentro': this.hemocentro.toJson(),
      };
}
