class GastoModel {
  int? idGasto;
  int? idPessoaFavorita;

  num valorComida;
  num valorBebida;

  GastoModel({
    this.idGasto,
    this.idPessoaFavorita,
    required this.valorComida,
    required this.valorBebida,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'valorComida': valorComida,
      'valorBebida': valorBebida,
    };
  }

  factory GastoModel.fromJson(Map<String, dynamic> map) {
    return GastoModel(
      idGasto: map['idGasto'],
      idPessoaFavorita: map['idPessoaFavorita'],
      valorComida: map['valorComida'] ?? 0.00,
      valorBebida: map['valorBebida'] ?? 0.00,
    );
  }

  factory GastoModel.empty() {
    return GastoModel.fromJson({});
  }

  GastoModel copyWith({
    int? idGasto,
    int? idPessoaFavorita,
    int? idConta,
    num? valorComida,
    num? valorBebida,
  }) {
    return GastoModel(
      idGasto: idGasto ?? this.idGasto,
      idPessoaFavorita: idPessoaFavorita ?? this.idPessoaFavorita,
      valorComida: valorComida ?? this.valorComida,
      valorBebida: valorBebida ?? this.valorBebida,
    );
  }
}
