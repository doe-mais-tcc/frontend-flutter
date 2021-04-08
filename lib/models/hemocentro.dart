class Hemocentro {
  int id;
  String nome;
  String endereco;
  String cidade;
  String url;
  Hemocentro({
    this.id,
    this.nome,
    this.endereco,
    this.cidade,
    this.url,
  });

  factory Hemocentro.fromJson(Map<String, dynamic> json) => Hemocentro(
        id: json['id'],
        nome: json['nome'],
        endereco: json['endereco'],
        cidade: json['cidade'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'nome': this.nome,
        'endereco': this.endereco,
        'cidade': this.cidade,
        'url': this.url,
      };
}
