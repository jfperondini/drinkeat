import 'package:drinkeat/domain/model/conta/pessoa_favorita.dart';
import 'package:drinkeat/domain/model/conta/despesa_model.dart';
import 'package:drinkeat/domain/model/conta/valor_arredondado_model.dart';

class ContaModel {
  int? idConta;
  String? nome;
  String? data;
  num valorTotal;
  List<PessoaFavoritaModel> listPessoaFavorita;
  List<DespesaModel> listDespesa;
  ValorArredondadoModel valorArredondado;

  ContaModel({
    this.idConta,
    required this.nome,
    required this.data,
    required this.valorTotal,
    required this.listPessoaFavorita,
    required this.listDespesa,
    required this.valorArredondado,
  });

  Map<String, dynamic> toJsonService() {
    return <String, dynamic>{
      'nome': nome,
      'data': data,
      'valorTotal': valorTotal,
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'idConta': idConta,
      'nome': nome,
      'data': data,
      'valorTotal': valorTotal,
      'listPessoaFavorita': listPessoaFavorita.map((e) => e.toJson()).toList(),
      'listDespesa': listDespesa.map((e) => e.toJson()).toList(),
      'valorArredondado': valorArredondado,
    };
  }

  factory ContaModel.fromJson(Map<String, dynamic> map) {
    return ContaModel(
      idConta: map['idConta'],
      nome: map['nome'] ?? '',
      data: map['data'] ?? '',
      valorTotal: map['valorTotal'] ?? 0.00,
      listPessoaFavorita: (map['listPessoaFavorita'] as List<dynamic>?)?.map((e) => PessoaFavoritaModel.fromJson(e)).toList() ?? [],
      listDespesa: (map['listDespesa'] as List<dynamic>?)?.map((e) => DespesaModel.fromJson(e)).toList() ?? [],
      valorArredondado: ValorArredondadoModel.fromJson(map['valorArredondado'] ?? {}),
    );
  }

  factory ContaModel.empty() {
    return ContaModel.fromJson({});
  }

  ContaModel copyWith({
    int? idConta,
    String? nome,
    String? data,
    num? valorTotal,
    List<PessoaFavoritaModel>? listPessoaFavorita,
    List<DespesaModel>? listDespesa,
    ValorArredondadoModel? valorArredondado,
  }) {
    return ContaModel(
        idConta: idConta ?? this.idConta,
        nome: nome ?? this.nome,
        data: data ?? this.data,
        valorTotal: valorTotal ?? this.valorTotal,
        listPessoaFavorita: listPessoaFavorita ?? this.listPessoaFavorita,
        listDespesa: listDespesa ?? this.listDespesa,
        valorArredondado: valorArredondado ?? this.valorArredondado);
  }
}
