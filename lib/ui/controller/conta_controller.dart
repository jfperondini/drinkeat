import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/extension/data_extension.dart';
import 'package:drinkeat/cors/shared/extension/num_extension.dart';
import 'package:drinkeat/domain/model/conta/despesa_model.dart';
import 'package:drinkeat/domain/model/conta/valor_arredondado_model.dart';
import 'package:drinkeat/ui/view/conta/widgets/despesa_widget.dart';
import 'package:drinkeat/ui/view/conta/widgets/pessoa_favorita_widget.dart';
import 'package:drinkeat/ui/view/conta/widgets/nome_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:drinkeat/domain/model/conta_model.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContaController extends ChangeNotifier {
  final HomeController home;

  ContaController(this.home);

  ContaModel get contaSelect => home.contaSelect ?? ContaModel.empty();

  final nome = TextEditingController();
  final data = TextEditingController(text: selectedDate.formatDateTime);

  int currentStep = 0;
  bool isLastStep = false;

  int totalBebeu = 0;
  int totalComeu = 0;

  clearConta() {
    home.contaSelect = ContaModel.empty();
    notifyListeners();
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Tipo'),
          content: const NameDateWidget(),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Pessoas'),
          content: const PessoaFavoritaWidget(),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Despesas'),
          content: const DespesaWidget(),
        ),
      ];

  stepContinue() async {
    final isLastStep = currentStep == getSteps().length - 1;
    if (isLastStep) {
      if (nome.text.isEmpty) {
        return 'O campo de nome está vazio.';
      } else if (data.text.isEmpty) {
        return 'O campo de data está vazio.';
      } else if (contaSelect.listPessoaFavorita.isEmpty) {
        return 'lista de participantes está vazia.';
      } else {
        await nomeDataJanta();
        await quemComeu();
        await quemBebeu();
        await calcularArrendondamento();
        await Modular.to.pushNamed(Routes.arredondar);
      }
    } else {
      currentStep < 2 ? currentStep += 1 : null;
    }
    notifyListeners();
  }

  stepTapped(int step) {
    currentStep = step;
    notifyListeners();
  }

  stepCancel() {
    currentStep > 0 ? currentStep -= 1 : null;
    notifyListeners();
  }

  stepClear() {
    currentStep = 0;
    notifyListeners();
  }

  nomeDataJanta() {
    contaSelect.nome = nome.text;
    contaSelect.data = data.text;
    notifyListeners();
  }

  clearNomeData() {
    nome.text = '';
    data.text = DateTime.now().formatDateTime;
    notifyListeners();
  }

  toggleIsBebeu({required int index}) async {
    contaSelect.listPessoaFavorita[index].bebeu = !contaSelect.listPessoaFavorita[index].bebeu;
    notifyListeners();
  }

  deleteByPessoaFavorite({required int index}) {
    contaSelect.listPessoaFavorita.removeAt(index);
    notifyListeners();
  }

  quemComeu() {
    if (contaSelect.listPessoaFavorita.isNotEmpty) {
      totalComeu = contaSelect.listPessoaFavorita.where((pessoa) => pessoa.comeu == true).length;
      return totalComeu;
    }
  }

  quemBebeu() {
    if (contaSelect.listPessoaFavorita.isNotEmpty) {
      totalBebeu = contaSelect.listPessoaFavorita.where((pessoa) => pessoa.bebeu == true).length;
      return totalBebeu;
    }
    notifyListeners();
  }

  Future<dynamic> deleteDespesa({required int index}) async {
    DespesaModel find = contaSelect.listDespesa.firstWhere((it) => it == contaSelect.listDespesa[index]);
    contaSelect.listDespesa.removeAt(contaSelect.listDespesa.indexOf(find));
    notifyListeners();
  }

  deleteGastoParticipante({required int index}) {
    contaSelect.listPessoaFavorita[index].gasto.valorBebida = 0.00;
    contaSelect.listPessoaFavorita[index].gasto.valorComida = 0.00;
    notifyListeners();
  }

  calcularArrendondamento() {
    num gastoBebida =
        contaSelect.listPessoaFavorita.isNotEmpty ? contaSelect.listPessoaFavorita.map((e) => e.gasto.valorBebida).reduce((v, e) => v + e) : 0.00;
    num gastoComida =
        contaSelect.listPessoaFavorita.isNotEmpty ? contaSelect.listPessoaFavorita.map((e) => e.gasto.valorComida).reduce((v, e) => v + e) : 0.00;
    num gastoDiverso = contaSelect.listDespesa.isNotEmpty ? contaSelect.listDespesa.map((e) => e.valor).reduce((v, e) => v + e) : 0.0;

    ValorArredondadoModel newValorArredondado = ValorArredondadoModel(
      valorDiversoPessoa: (gastoDiverso / totalComeu).toPrecision(2),
      valorComidaPessoa: ((gastoComida) / (totalComeu)).toPrecision(2),
      valorBebidaPessoa: (totalBebeu != 0 ? (gastoBebida / totalBebeu).toPrecision(2) : 0.0),
      valorDiversoComidaPessoa: (gastoDiverso / totalComeu).toPrecision(2) + ((gastoComida) / (totalComeu)).toPrecision(2),
    );
    contaSelect.valorArredondado = newValorArredondado;
    notifyListeners();
  }
}
