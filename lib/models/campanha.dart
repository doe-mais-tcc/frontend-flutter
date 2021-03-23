class Campanha {
  int id;
  String cidade;
  String descricao;
  String nome;
  int idHemocentro;
  int idUser;

  Campanha({
    this.id,
    this.cidade,
    this.descricao,
    this.nome,
    this.idHemocentro,
    this.idUser,
  });

  factory Campanha.fromJson(Map<String, dynamic> json) => Campanha(
        id: json['id'],
        cidade: json['cidade'],
        descricao: json['descricao'],
        nome: json['nome'],
        idHemocentro: json['id_hemocentro'],
        idUser: json['id_user'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'cidade': this.cidade,
        'descricao': this.descricao,
        'nome': this.nome,
        'id_hemocentro': this.idHemocentro,
        'id_user': this.idUser,
      };
}
