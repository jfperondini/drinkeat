import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/widgets/card_widget.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/domain/model/conta/despesa_model.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita.dart';
import 'package:drinkeat/ui/controller/conta_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class DespesaWidget extends StatelessWidget {
  const DespesaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final conta = Modular.get<ContaController>();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return ListenableBuilder(
      listenable: conta,
      builder: (context, snapshot) {
        return Column(
          children: [
            ElevatedButtonWidget(
              onPressed: () async {
                if (conta.contaSelect.listPessoaFavorita.isNotEmpty) {
                  await Modular.to.pushNamed(Routes.despesa);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Não há participantes na lista. Por favor, adicione pelo menos um participante.',
                      ),
                      backgroundColor: Styles.redAccent,
                    ),
                  );
                }
              },
              title: 'Adicionar Despesa',
            ),
            SizedBox(height: size.height * 0.02),
            SingleChildScrollView(
              child: SizedBox(
                height: size.height * 0.6,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: conta.contaSelect.listDespesa.length + conta.contaSelect.listPessoaFavorita.length,
                  itemBuilder: (context, index) {
                    if (index < conta.contaSelect.listDespesa.length) {
                      final despesaIndex = index;
                      return CardWidget(
                        title: Text(
                          conta.contaSelect.listDespesa[despesaIndex].tipo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Styles.black.withOpacity(0.8),
                          ),
                        ),
                        subtitle: Text(
                          'Diverso: ${real.format(conta.contaSelect.listDespesa[despesaIndex].valor)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Styles.black.withOpacity(0.8),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await conta.deleteDespesa(index: despesaIndex);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Styles.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Modular.to.pushNamed(
                            Routes.despesa,
                            arguments: {
                              "despesaModel": conta.contaSelect.listDespesa[despesaIndex],
                              "pessoaModel": PessoaFavoritaModel.empty(),
                              "tipoDespesa": 'Outros',
                            },
                          );
                        },
                      );
                    } else {
                      final pessoaIndex = index - conta.contaSelect.listDespesa.length;
                      return Column(
                        children: [
                          if (conta.contaSelect.listPessoaFavorita[pessoaIndex].gasto.valorComida != 0.00 ||
                              conta.contaSelect.listPessoaFavorita[pessoaIndex].gasto.valorBebida != 0.00)
                            CardWidget(
                              title: Text(
                                conta.contaSelect.listPessoaFavorita[pessoaIndex].nome,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Styles.black.withOpacity(0.8),
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (conta.contaSelect.listPessoaFavorita[pessoaIndex].gasto.valorComida != 0.00)
                                    Text(
                                      'Comida: ${real.format(
                                        conta.contaSelect.listPessoaFavorita[pessoaIndex].gasto.valorComida,
                                      )}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Styles.black.withOpacity(0.8),
                                      ),
                                    ),
                                  if (conta.contaSelect.listPessoaFavorita[pessoaIndex].gasto.valorBebida != 0.00)
                                    Text(
                                      'Bebida: ${real.format(
                                        conta.contaSelect.listPessoaFavorita[pessoaIndex].gasto.valorBebida,
                                      )}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Styles.black.withOpacity(0.8),
                                      ),
                                    ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      conta.deleteGastoParticipante(index: pessoaIndex);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Styles.black.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Modular.to.pushNamed(
                                  Routes.despesa,
                                  arguments: {
                                    "despesaModel": DespesaModel.empty(),
                                    "pessoaModel": conta.contaSelect.listPessoaFavorita[pessoaIndex],
                                    "tipoDespesa": 'Integrante',
                                  },
                                );
                              },
                            ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
