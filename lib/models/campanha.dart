import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/models/user.dart';

class Campanha {
  int id;
  bool compartilhavel;
  String descricao;
  String nomeInternado;
  String tipoSanguineo;
  Hemocentro hemocentro;
  User user;

  Campanha({
    this.id,
    this.compartilhavel,
    this.descricao,
    this.nomeInternado,
    this.tipoSanguineo,
    this.hemocentro,
    this.user,
  });

  factory Campanha.fromJson(Map<String, dynamic> json) => Campanha(
        id: json['id'],
        compartilhavel: json['compartilhavel'],
        descricao: json['descricao'],
        nomeInternado: json['nomeInternado'],
        tipoSanguineo: json['tipoSanguineo'],
        hemocentro: Hemocentro.fromJson(json['hemocentro']),
        user: User.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'compartilhavel': this.compartilhavel,
        'descricao': this.descricao,
        'nomeInternado': this.nomeInternado,
        'tipoSanguineo': this.tipoSanguineo,
        'hemocentro': this.hemocentro.toJson(),
        'user': this.user.toJson(),
      };
}
