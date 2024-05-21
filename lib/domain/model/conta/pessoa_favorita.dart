import 'package:drinkeat/domain/model/conta/pessoa_favorita/gasto_model.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita/pagamento_model.dart';

class PessoaFavoritaModel {
  int? idPessoaFavorita;
  int? idConta;
  String nome;
  bool favorito;
  bool comeu;
  bool bebeu;
  GastoModel gasto;
  PagamentoModel pagamento;

  PessoaFavoritaModel({
    this.idPessoaFavorita,
    this.idConta,
    required this.nome,
    this.favorito = false,
    required this.comeu,
    required this.bebeu,
    required this.gasto,
    required this.pagamento,
  });

  Map<String, dynamic> toJsonService() {
    return <String, dynamic>{
      'nome': nome,
      'comeu': comeu,
      'bebeu': bebeu,
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idPessoaFavorita': idPessoaFavorita,
      'idConta': idConta,
      'nome': nome,
      'favorito': favorito,
      'comeu': comeu,
      'bebeu': bebeu,
    };
  }

  factory PessoaFavoritaModel.fromJson(Map<String, dynamic> map) {
    return PessoaFavoritaModel(
      idPessoaFavorita: map['idPessoaFavorita'],
      idConta: map['idConta'],
      nome: map['nome'] ?? '',
      favorito: map['favorito'] ?? false,
      comeu: map['comeu'] ?? true,
      bebeu: map['bebeu'] ?? false,
      gasto: GastoModel.fromJson(map['gasto'] ?? {}),
      pagamento: PagamentoModel.fromJson(map['pagamento'] ?? {}),
    );
  }

  factory PessoaFavoritaModel.empty() {
    return PessoaFavoritaModel.fromJson({});
  }

  PessoaFavoritaModel copyWith({
    int? idPessoaFavorita,
    int? idConta,
    String? nome,
    bool? favorito,
    bool? comeu,
    bool? bebeu,
    GastoModel? gasto,
    PagamentoModel? pagamento,
  }) {
    return PessoaFavoritaModel(
      idPessoaFavorita: idPessoaFavorita ?? this.idPessoaFavorita,
      idConta: idConta ?? this.idConta,
      nome: nome ?? this.nome,
      favorito: favorito ?? this.favorito,
      comeu: comeu ?? this.comeu,
      bebeu: bebeu ?? this.bebeu,
      gasto: gasto ?? this.gasto,
      pagamento: pagamento ?? this.pagamento,
    );
  }
}
