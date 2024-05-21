class DespesaModel {
  int? idDespesa;
  int? idConta;
  String tipo;
  num valor;

  DespesaModel({
    this.idDespesa,
    this.idConta,
    required this.tipo,
    required this.valor,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idConta': idConta,
      'tipo': tipo,
      'valor': valor,
    };
  }

  factory DespesaModel.fromJson(Map<String, dynamic> map) {
    return DespesaModel(
      idDespesa: map['idDespesa'],
      idConta: map['idConta'],
      tipo: map['tipo'] ?? '',
      valor: map['valor'] ?? 0.00,
    );
  }

  factory DespesaModel.empty() {
    return DespesaModel.fromJson({});
  }

  DespesaModel copyWith({
    int? idDespesa,
    int? idConta,
    String? tipo,
    num? valor,
  }) {
    return DespesaModel(
      idDespesa: idDespesa ?? this.idDespesa,
      idConta: idConta ?? this.idConta,
      tipo: tipo ?? this.tipo,
      valor: valor ?? this.valor,
    );
  }
}
