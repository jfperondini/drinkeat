import 'package:drinkeat/cors/shared/extension/num_extension.dart';
import 'package:drinkeat/domain/model/conta/valor_arredondado_model.dart';
import 'package:drinkeat/domain/model/conta_model.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';
import 'package:flutter/material.dart';

class ArredondarController extends ChangeNotifier {
  final HomeController home;

  ArredondarController(this.home);

  ContaModel get contaSelect => home.contaSelect ?? ContaModel.empty();

  bool isMultipleBebida = false;
  bool isMultipComida = false;

  isMultipleOf({required num value}) {
    return value % 5 != 0;
  }

  toggleBebida() {
    isMultipleBebida = !isMultipleBebida;
    notifyListeners();
  }

  roundBebida() {
    if (isMultipleBebida != false) {
      contaSelect.valorArredondado.valorBebidaPessoa = contaSelect.valorArredondado.valorBebidaToFloor;
    } else {
      contaSelect.valorArredondado.valorBebidaPessoa = contaSelect.valorArredondado.valorBebidaToCeil;
    }
    notifyListeners();
  }

  valorAPagarBebida() {
    for (final pessoa in contaSelect.listPessoaFavorita) {
      if (pessoa.bebeu == true) {
        pessoa.pagamento.valorBebida = contaSelect.valorArredondado.valorBebidaPessoa;
      }
    }
    notifyListeners();
  }

  toggleComida() {
    isMultipComida = !isMultipComida;
    notifyListeners();
  }

  roundComida() {
    if (isMultipComida != false) {
      contaSelect.valorArredondado.valorDiversoComidaPessoa = contaSelect.valorArredondado.valorDiversoComidaToFloor;
    } else {
      contaSelect.valorArredondado.valorDiversoComidaPessoa = contaSelect.valorArredondado.valorDiversoComidaToCeil;
    }
    notifyListeners();
  }

  proportionComida() {
    num proporcaoComida = contaSelect.valorArredondado.valorComidaPessoa / contaSelect.valorArredondado.valorDiversoComida;
    num proporcaoDiverso = contaSelect.valorArredondado.valorDiversoPessoa / contaSelect.valorArredondado.valorDiversoComida;
    num novoValorComidaPessoa = (proporcaoComida * contaSelect.valorArredondado.valorDiversoComidaPessoa).toPrecision(1);
    num novoValorDiversoPessoa = (proporcaoDiverso * contaSelect.valorArredondado.valorDiversoComidaPessoa).toPrecision(1);
    contaSelect.valorArredondado.valorComidaPessoa = novoValorComidaPessoa;
    contaSelect.valorArredondado.valorDiversoPessoa = novoValorDiversoPessoa;
    notifyListeners();
  }

  valorAPagarComida() {
    for (final pessoa in contaSelect.listPessoaFavorita) {
      pessoa.pagamento.valorComida = contaSelect.valorArredondado.valorComidaPessoa;
      pessoa.pagamento.valorDiverso = contaSelect.valorArredondado.valorDiversoPessoa;
    }
    notifyListeners();
  }

  valorAPagar() {
    for (final pessoa in contaSelect.listPessoaFavorita) {
      num gasto = pessoa.gasto.valorBebida + pessoa.gasto.valorComida;
      num pago = pessoa.pagamento.valorBebida + pessoa.pagamento.valorComida + pessoa.pagamento.valorDiverso;
      num valorAPagar = gasto - pago;
      pessoa.pagamento.valorAPagar = valorAPagar.isMultipleOf(valorAPagar);
    }
    notifyListeners();
  }

  clearArredondar() {
    contaSelect.valorArredondado = ValorArredondadoModel.empty();
    notifyListeners();
  }

  clearPago() {
    for (int i = 0; i < contaSelect.listPessoaFavorita.length; i++) {
      contaSelect.listPessoaFavorita[i].pagamento.pago = false;
    }
    notifyListeners();
  }
}
