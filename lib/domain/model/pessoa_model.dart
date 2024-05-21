class PessoaModel {
  int? idPessoa;
  String nome;
  bool favorito;

  PessoaModel({
    this.idPessoa,
    required this.nome,
    this.favorito = false,
  });

  Map<String, dynamic> toJsonService() {
    return <String, dynamic>{
      'nome': nome,
      'favorito': favorito,
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idPessoa': idPessoa,
      'nome': nome,
      'favorito': favorito,
    };
  }

  factory PessoaModel.fromJson(Map<String, dynamic> map) {
    return PessoaModel(
      idPessoa: map['idPessoa'],
      nome: map['nome'] ?? '',
      favorito: map['favorito'] ?? false,
    );
  }

  factory PessoaModel.empty() {
    return PessoaModel.fromJson({});
  }
}
