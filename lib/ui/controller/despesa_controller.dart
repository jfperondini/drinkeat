import 'package:drinkeat/cors/shared/extension/string_extension.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita.dart';
import 'package:drinkeat/domain/model/conta/despesa_model.dart';
import 'package:flutter/material.dart';
import 'package:drinkeat/domain/model/conta_model.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';

class DespesaController extends ChangeNotifier {
  final HomeController home;

  DespesaController(this.home);

  ContaModel get contaSelect => home.contaSelect ?? ContaModel.empty();
  PessoaFavoritaModel? pessoaSelect;
  DespesaModel? despesaModel;

  final tipo = TextEditingController();
  final valor = TextEditingController();

  final valorComida = TextEditingController();
  final valorBebida = TextEditingController();

  String? tipoDespesa = '';

  int? _isPessoaSelect;
  int get isPessoaSelect => _isPessoaSelect ??= -1;

  handleTipoDespesa(String value) {
    tipoDespesa = value;
    notifyListeners();
  }

  clearTipoDespesa() {
    tipoDespesa = '';
    notifyListeners();
  }

  handlePessoaSelect({required PessoaFavoritaModel? pessoaModel}) {
    if (pessoaModel != null && contaSelect.listPessoaFavorita.isNotEmpty) {
      pessoaSelect = pessoaModel;
      _isPessoaSelect = contaSelect.listPessoaFavorita.indexOf(pessoaModel);
    }
    notifyListeners();
  }

  clearPessoaSelect() {
    _isPessoaSelect = null;
    pessoaSelect = null;
    notifyListeners();
  }

  List<PessoaFavoritaModel> listFiltrada = [];
  List<PessoaFavoritaModel> filterListPessoaFavorita() {
    listFiltrada = contaSelect.listPessoaFavorita.where((pessoa) {
      return pessoa.gasto.valorBebida == 0.0 && pessoa.gasto.valorComida == 0.0;
    }).toList();
    return listFiltrada;
  }

  num parseCurrencyInput({required String input}) {
    if (input.isEmpty) return 0;
    return num.parse(input.toReplaceCoinFormat(input)) / 100;
  }

  creatGastoParcipante(int index, PessoaFavoritaModel pessoaModel) {
    if (index != -1) {
      contaSelect.listPessoaFavorita[index].gasto.valorComida = parseCurrencyInput(input: valorComida.text);
      contaSelect.listPessoaFavorita[index].gasto.valorBebida = parseCurrencyInput(input: valorBebida.text);
    } else {
      int existingIndex = contaSelect.listPessoaFavorita.indexWhere((pessoa) => pessoa.nome == pessoaModel.nome);
      if (existingIndex != -1) {
        if (valorComida.text != '') contaSelect.listPessoaFavorita[existingIndex].gasto.valorComida = parseCurrencyInput(input: valorComida.text);
        if (valorBebida.text != '') contaSelect.listPessoaFavorita[existingIndex].gasto.valorBebida = parseCurrencyInput(input: valorBebida.text);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  clearGastoComidaBebida() {
    valorComida.text = '';
    valorBebida.text = '';
    notifyListeners();
  }

  creatDespesa() {
    num newValor = parseCurrencyInput(input: valor.text);
    DespesaModel newDespesa = DespesaModel(
      tipo: tipo.text.isNotEmpty ? tipo.text : despesaModel?.tipo ?? '',
      valor: valor.text.isNotEmpty ? newValor : despesaModel?.valor ?? 0.00,
    );
    int existingIndex = contaSelect.listDespesa.indexWhere((despesa) => despesa.tipo == newDespesa.tipo);
    if (existingIndex != -1) {
      contaSelect.listDespesa[existingIndex].valor = newDespesa.valor;
    } else {
      contaSelect.listDespesa.add(newDespesa);
    }
    notifyListeners();
  }

  clearDespesa() {
    tipo.text = '';
    valor.text = '';
    notifyListeners();
  }
}
