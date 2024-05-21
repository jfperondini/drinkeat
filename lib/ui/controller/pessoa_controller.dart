import 'package:drinkeat/data/service/pessoa_service.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita/gasto_model.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita/pagamento_model.dart';
import 'package:drinkeat/domain/model/conta_model.dart';
import 'package:drinkeat/domain/model/pessoa_model.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';
import 'package:flutter/material.dart';

class PessoaController extends ChangeNotifier {
  final HomeController home;
  final PessoaService pessoaService;

  PessoaController(this.pessoaService, this.home);

  ContaModel? get contaSelect => home.contaSelect;
  List<PessoaModel> listPessoa = [];

  final name = TextEditingController();

  bool nameIsExists = false;

  getListPessoa() async {
    listPessoa = await pessoaService.getList();
    listPessoa.sort((a, b) => a.nome.compareTo(b.nome));
    notifyListeners();
  }

  createPessoa() async {
    PessoaModel newPessoa = PessoaModel(
      nome: name.text.toLowerCase(),
      favorito: false,
    );

    List<String> nomesExistentes = listPessoa.map((p) => p.nome.toLowerCase()).toList();
    nameIsExists = nomesExistentes.contains(name.text.toLowerCase());
    if (!nameIsExists) {
      await pessoaService.post(pessoa: newPessoa);
      await getListPessoa();
    } else {
      return 'O nome ${name.text} já existe na lista.';
    }
    notifyListeners();
  }

  filterIsFavorite() {
    if (contaSelect != null && contaSelect?.listPessoaFavorita != null) {
      List<PessoaModel> listFavorito = listPessoa.where((pessoa) => pessoa.favorito == true).toList();
      if (contaSelect?.listPessoaFavorita.isEmpty ?? false) {
        createPessoaFavorita(listPessoa: listFavorito);
      } else {
        List<PessoaModel> newFavoritos = listFavorito
            .where((pessoa) => !(contaSelect?.listPessoaFavorita.any((favorita) => favorita.idPessoaFavorita == pessoa.idPessoa) ?? false))
            .toList();
        createPessoaFavorita(listPessoa: newFavoritos);
      }
    }
    notifyListeners();
  }

  createPessoaFavorita({required List<PessoaModel> listPessoa}) {
    contaSelect?.listPessoaFavorita.sort((a, b) => a.nome.compareTo(b.nome));
    for (int i = 0; i < listPessoa.length; i++) {
      contaSelect?.listPessoaFavorita.add(PessoaFavoritaModel(
        idPessoaFavorita: listPessoa[i].idPessoa,
        nome: listPessoa[i].nome,
        favorito: listPessoa[i].favorito,
        comeu: true,
        bebeu: false,
        gasto: GastoModel.empty(),
        pagamento: PagamentoModel.empty(),
      ));
    }
  }

  deleteById({required PessoaModel pessoa}) async {
    await pessoaService.delete(id: pessoa.idPessoa ?? -1);
    notifyListeners();
  }

  toggleIsFavorite({required int index}) async {
    listPessoa[index].favorito = !listPessoa[index].favorito;
    await pessoaService.patch(
      pessoa: listPessoa[index],
      body: {'favorito': listPessoa[index].favorito},
    );
    notifyListeners();
  }

  deleteByFavorite({required String nome}) async {
    PessoaModel pessoa = listPessoa.firstWhere((element) => element.nome == nome);
    await pessoaService.patch(
      pessoa: pessoa,
      body: {'favorito': false},
    );
    notifyListeners();
  }

  clearNome() {
    name.text = '';
    notifyListeners();
  }
}
