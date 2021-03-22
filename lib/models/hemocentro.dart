class Hemocentro {
  int id;
  String bairro;
  String cidade;
  String nome;
  String rua;

  Hemocentro({
    this.id,
    this.bairro,
    this.cidade,
    this.nome,
    this.rua,
  });

  factory Hemocentro.fromJson(Map<String, dynamic> json) {
    return Hemocentro(
      id: json['id'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      nome: json['nome'],
      rua: json['rua'],
    );
  }
}
