import 'package:drinkeat/data/service/conta_service.dart';
import 'package:drinkeat/data/service/despesa_service.dart';
import 'package:drinkeat/data/service/gasto_service.dart';
import 'package:drinkeat/data/service/pagamento_service.dart';
import 'package:drinkeat/data/service/pessoa_favorita_service.dart';
import 'package:drinkeat/domain/model/conta_model.dart';
import 'package:drinkeat/domain/model/conta/valor_arredondado_model.dart';
import 'package:drinkeat/domain/model/pessoa_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  final ContaService contaService;
  final DespesaService despesaService;
  final PessoaFavoritaService pessoaFavoritaService;
  final GastoService gastoService;
  final PagamentoService pagamentoService;

  HomeController(
    this.contaService,
    this.despesaService,
    this.pessoaFavoritaService,
    this.gastoService,
    this.pagamentoService,
  );

  ContaModel? contaSelect;
  List<PessoaModel> listPessoa = [];

  creatConta() {
    ContaModel? newConta = ContaModel(
      nome: null,
      data: null,
      valorTotal: contaSelect?.valorTotal ?? 0.00,
      listPessoaFavorita: [],
      listDespesa: [],
      valorArredondado: ValorArredondadoModel.empty(),
    );
    contaSelect = newConta;
    notifyListeners();
  }

  double lengthValue() {
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    String? valorTotal = real.format(contaSelect?.valorTotal ?? 0.00);
    int quantidadeCaracteres = valorTotal.length;
    if (quantidadeCaracteres >= 13) {
      return 18;
    }
    return 26;
  }

  toggleIsPago({required int index}) {
    num valorComida = contaSelect?.valorArredondado.valorComidaPessoa ?? 0.00;
    num valorBebida = contaSelect?.valorArredondado.valorBebidaPessoa ?? 0.00;
    num valorDiverso = contaSelect?.valorArredondado.valorDiversoPessoa ?? 0.00;

    if (contaSelect?.listPessoaFavorita[index].pagamento.pago == true) {
      if (contaSelect?.listPessoaFavorita[index].bebeu == true) {
        num alteracaoTotal = valorComida + valorBebida + valorDiverso;
        contaSelect?.valorTotal = (contaSelect?.valorTotal ?? 0.00) + (alteracaoTotal);
      } else {
        num alteracaoTotal = valorComida + valorDiverso;
        contaSelect?.valorTotal = (contaSelect?.valorTotal ?? 0.00) + (alteracaoTotal);
      }
    } else {
      if (contaSelect?.listPessoaFavorita[index].bebeu == true) {
        num alteracaoTotal = valorComida + valorBebida + valorDiverso;
        contaSelect?.valorTotal = (contaSelect?.valorTotal ?? 0.00) - (alteracaoTotal);
      } else {
        num alteracaoTotal = valorComida + valorDiverso;
        contaSelect?.valorTotal = (contaSelect?.valorTotal ?? 0.00) - (alteracaoTotal);
      }
    }

    final conta = contaSelect;
    if (conta != null) {
      conta.listPessoaFavorita[index].pagamento.pago = !(conta.listPessoaFavorita[index].pagamento.pago);
    }
    notifyListeners();
  }

  insertConta() async {
    final listPessoaFavorita = contaSelect?.listPessoaFavorita ?? [];
    final listDespesa = contaSelect?.listDespesa ?? [];

    ContaModel? newConta = await contaService.post(conta: contaSelect ?? ContaModel.empty());

    for (int i = 0; i < listPessoaFavorita.length; i++) {
      await pessoaFavoritaService.post(pessoaFavorita: listPessoaFavorita[i]);
      await gastoService.post(gasto: listPessoaFavorita[i].gasto);
      await pagamentoService.post(pagamento: listPessoaFavorita[i].pagamento);
    }

    for (int i = 0; i < listDespesa.length; i++) {
      listDespesa[i].idConta = newConta.idConta;
      await despesaService.post(despesa: listDespesa[i]);
    }

    notifyListeners();
  }

  checkTodosPagos() {
    final listPessoa = contaSelect?.listPessoaFavorita ?? [];
    bool todosPagos = listPessoa.every((pessoa) => pessoa.pagamento.pago == true);
    if (todosPagos) {
      clearConta();
    } else {
      return 'Falta pagar algumas pessoas';
    }
    notifyListeners();
  }

  clearConta() {
    contaSelect?.listPessoaFavorita = [];
    contaSelect?.listDespesa = [];
    contaSelect = ContaModel.empty();
    notifyListeners();
  }

  updateConta() {
    contaSelect?.listPessoaFavorita.forEach((pessoa) {
      pessoa.pagamento.pago = false;
    });
    contaSelect?.valorTotal = 0.00;
    contaSelect?.valorArredondado = ValorArredondadoModel.empty();
    notifyListeners();
  }
}
