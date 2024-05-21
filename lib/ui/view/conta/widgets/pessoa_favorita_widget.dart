import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/widgets/card_widget.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/ui/controller/conta_controller.dart';
import 'package:drinkeat/ui/controller/pessoa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PessoaFavoritaWidget extends StatelessWidget {
  const PessoaFavoritaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    final conta = Modular.get<ContaController>();
    final pessoa = Modular.get<PessoaController>();
    return ListenableBuilder(
      listenable: conta,
      builder: (context, snapshot) {
        return ListenableBuilder(
          listenable: pessoa,
          builder: (context, snapshot) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await pessoa.getListPessoa();
                      await Modular.to.pushNamed(Routes.pessoa);
                    },
                    title: 'Adicionar Pessoa',
                  ),
                  SizedBox(height: size.height * 0.02),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: size.height * 0.6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: conta.contaSelect.listPessoaFavorita.length,
                        itemBuilder: (context, index) {
                          return CardWidget(
                            title: Text(
                              conta.contaSelect.listPessoaFavorita[index].nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Styles.black.withOpacity(0.8),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Bebeu?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Styles.black.withOpacity(0.8),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    conta.toggleIsBebeu(index: index);
                                  },
                                  icon: Icon(
                                    (conta.contaSelect.listPessoaFavorita[index].bebeu) ? Icons.sports_bar_sharp : Icons.sports_bar_outlined,
                                    color: (conta.contaSelect.listPessoaFavorita[index].bebeu)
                                        ? Styles.orange
                                        : Styles.black.withOpacity(
                                            0.8,
                                          ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final pessoaFavorita = conta.contaSelect.listPessoaFavorita[index];
                                    if (pessoaFavorita.gasto.valorComida > 0) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Não é possível retirar ${pessoaFavorita.nome} dos favoritos devido a gastos pendentes.',
                                          ),
                                          backgroundColor: Styles.redAccent,
                                        ),
                                      );
                                    } else {
                                      await conta.deleteByPessoaFavorite(index: index);
                                      await pessoa.deleteByFavorite(nome: pessoaFavorita.nome);
                                      await pessoa.getListPessoa();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: Styles.orange,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
