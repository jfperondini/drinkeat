class PagamentoModel {
  int? idPagamento;
  int? idPessoaFavorita;
  num valorComida;
  num valorBebida;
  num valorDiverso;
  num valorAPagar;
  bool pago;

  PagamentoModel({
    required this.idPagamento,
    required this.idPessoaFavorita,
    required this.valorComida,
    required this.valorBebida,
    required this.valorDiverso,
    required this.valorAPagar,
    required this.pago,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'valorComida': valorComida,
      'valorBebida': valorBebida,
      'valorDiverso': valorDiverso,
      'valorAPagar': valorAPagar,
      'pago': pago,
    };
  }

  factory PagamentoModel.fromJson(Map<String, dynamic> map) {
    return PagamentoModel(
      idPagamento: map['idPagamento'],
      idPessoaFavorita: map['idPessoaFavorita'],
      valorComida: map['valorComida'] ?? 0.00,
      valorBebida: map['valorBebida'] ?? 0.00,
      valorDiverso: map['valorDiverso'] ?? 0.00,
      valorAPagar: map['valorAPagar'] ?? 0.00,
      pago: map['pago'] ?? false,
    );
  }

  factory PagamentoModel.empty() {
    return PagamentoModel.fromJson({});
  }

  PagamentoModel copyWith({
    int? idPagamento,
    int? idPessoaFavorita,
    num? valorComida,
    num? valorBebida,
    num? valorDiverso,
    num? valorAPagar,
    bool? pago,
  }) {
    return PagamentoModel(
      idPagamento: idPagamento ?? this.idPagamento,
      idPessoaFavorita: idPessoaFavorita ?? this.idPessoaFavorita,
      valorComida: valorComida ?? this.valorComida,
      valorBebida: valorBebida ?? this.valorBebida,
      valorDiverso: valorDiverso ?? this.valorDiverso,
      valorAPagar: valorAPagar ?? this.valorAPagar,
      pago: pago ?? this.pago,
    );
  }
}
