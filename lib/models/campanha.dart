import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/models/user.dart';

class Campanha {
  int id;
  User user;
  Hemocentro hemocentro;
  String nomeInternado;
  String tipoSanguineo;
  bool compartilhavel;
  String descricao;

  Campanha({
    this.id,
    this.user,
    this.hemocentro,
    this.nomeInternado,
    this.tipoSanguineo,
    this.compartilhavel,
    this.descricao,
  });

  factory Campanha.fromJson(Map<String, dynamic> json) => Campanha(
        id: json['id'],
        user: User.fromJson(json['user']),
        hemocentro: Hemocentro.fromJson(json['hemocentro']),
        nomeInternado: json['nome_internado'],
        tipoSanguineo: json['tipo_sanguineo'],
        compartilhavel: json['compartilhavel'],
        descricao: json['descricao'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'user': this.user.toJson(),
        'hemocentro': this.hemocentro.toJson(),
        'nome_internado': this.nomeInternado,
        'tipo_sanguineo': this.tipoSanguineo,
        'compartilhavel': this.compartilhavel,
        'descricao': this.descricao,
      };
}
