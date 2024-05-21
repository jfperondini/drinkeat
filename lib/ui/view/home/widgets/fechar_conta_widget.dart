// ignore_for_file: use_build_context_synchronously

import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/cors/shared/widgets/row_text_style_widget.dart';
import 'package:drinkeat/ui/controller/conta_controller.dart';
import 'package:drinkeat/ui/controller/despesa_controller.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class FecharContaWidgt extends StatelessWidget {
  const FecharContaWidgt({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final home = Modular.get<HomeController>();
    final conta = Modular.get<ContaController>();
    final despesa = Modular.get<DespesaController>();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return ListenableBuilder(
        listenable: home,
        builder: (context, snapshot) {
          return ListenableBuilder(
              listenable: conta,
              builder: (context, snapshot) {
                return ListenableBuilder(
                  listenable: despesa,
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        SizedBox(height: size.height * 0.05),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(30.0),
                              topRight: Radius.circular(8.0),
                            ),
                            border: Border.all(
                              color: Styles.black.withOpacity(0.8),
                              width: 1.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowTextStyleWidget(
                                      title: 'data',
                                      icon: Icons.calendar_month,
                                      subTitle: home.contaSelect?.data ?? '',
                                    ),
                                    RowTextStyleWidget(
                                      title: 'nome',
                                      icon: Icons.receipt,
                                      subTitle: home.contaSelect?.nome ?? '',
                                    ),
                                  ],
                                ),
                                Container(
                                  width: size.width * 0.42,
                                  height: size.height * 0.14,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(30.0),
                                        topRight: Radius.circular(8.0)),
                                    border: Border.all(
                                      color: Styles.orange,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Styles.black.withOpacity(0.8),
                                          ),
                                        ),
                                        Text(
                                          real.format(home.contaSelect?.valorTotal ?? 0.00),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: home.lengthValue(),
                                            color: (home.contaSelect?.valorTotal ?? 0) < 0 ? Styles.redAccent : Styles.blueAccent,
                                          ),
                                          softWrap: false, // Mantém o texto em uma única linha
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        SingleChildScrollView(
                          child: Container(
                            width: size.width * 1,
                            height: size.height * 0.55,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              border: Border.all(
                                color: Styles.black.withOpacity(0.8),
                                width: 1.5,
                              ),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: home.contaSelect?.listPessoaFavorita.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(
                                    Icons.person,
                                    color: (home.contaSelect?.listPessoaFavorita[index].pagamento.pago == true)
                                        ? Styles.orange
                                        : Styles.black.withOpacity(0.8),
                                  ),
                                  title: Text(
                                    home.contaSelect?.listPessoaFavorita[index].nome ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Styles.black.withOpacity(0.8),
                                    ),
                                  ),
                                  subtitle: Text(
                                    real.format(home.contaSelect?.listPessoaFavorita[index].pagamento.valorAPagar),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration:
                                          (home.contaSelect?.listPessoaFavorita[index].pagamento.pago == true) ? TextDecoration.lineThrough : null,
                                      fontSize: 18,
                                      color: (home.contaSelect?.listPessoaFavorita[index].pagamento.valorAPagar ?? 0) < 0
                                          ? Styles.redAccent
                                          : Styles.blueAccent,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      home.toggleIsPago(index: index);
                                    },
                                    icon: Icon(
                                      (home.contaSelect?.listPessoaFavorita[index].pagamento.pago == true)
                                          ? Icons.attach_money
                                          : Icons.money_off_csred,
                                      color: (home.contaSelect?.listPessoaFavorita[index].pagamento.pago == true)
                                          ? Styles.orange
                                          : Styles.black.withOpacity(0.8),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButtonWidget(
                                onPressed: () async {
                                  String? result = await home.checkTodosPagos();
                                  (result != null)
                                      ? ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(result),
                                            backgroundColor: Styles.redAccent,
                                          ),
                                        )
                                      : [
                                          await conta.stepClear(),
                                          await conta.clearNomeData(),
                                          await home.clearConta(),
                                          await despesa.clearDespesa(),
                                          await despesa.clearGastoComidaBebida(),
                                        ];
                                },
                                title: 'Fechar a Conta',
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            IconButton(
                              icon: Icon(
                                Icons.edit_document,
                                color: Styles.black.withOpacity(0.8),
                                size: 30,
                              ),
                              onPressed: () async {
                                if (home.contaSelect != null) {
                                  await home.updateConta();
                                  await Modular.to.pushNamed(Routes.conta);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              });
        });
  }
}
