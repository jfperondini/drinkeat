import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/widgets/radio_list_title_widget.dart';
import 'package:drinkeat/domain/model/conta/despesa_model.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita.dart';
import 'package:drinkeat/ui/controller/despesa_controller.dart';
import 'package:drinkeat/ui/view/despesa/widgets/gasto_participante_widget.dart';
import 'package:drinkeat/ui/view/despesa/widgets/gasto_outro_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DespesaPage extends StatelessWidget {
  final dynamic args;
  String? get tipoDespesa => (args != null) ? args['tipoDespesa'] : '';
  DespesaModel get despesaModel => (args != null) ? args['despesaModel'] : DespesaModel.empty();
  PessoaFavoritaModel get pessoaModel => (args != null) ? args['pessoaModel'] : PessoaFavoritaModel.empty();

  const DespesaPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final despesa = Modular.get<DespesaController>();
    despesa.despesaModel = despesaModel;
    return Scaffold(
      backgroundColor: Styles.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            despesa.clearGastoComidaBebida();
            despesa.clearDespesa();
            despesa.clearPessoaSelect();
            despesa.clearTipoDespesa();
            Modular.to.pop();
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Styles.black.withOpacity(0.8),
          ),
        ),
        title: Text(
          'Despesa',
          style: TextStyle(
            color: Styles.black.withOpacity(0.8),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: despesa,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.only(top: 8, left: 18, right: 18),
            color: Styles.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (tipoDespesa != '') ? '' : 'Qual é o tipo de despesa?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Styles.black.withOpacity(0.8),
                  ),
                ),
                Row(
                  children: (tipoDespesa != '')
                      ? []
                      : [
                          Expanded(
                            child: RadioListTitleWidget(
                              title: 'Integrante',
                              groupValue: despesa.tipoDespesa ?? '',
                              onChanged: (value) {
                                despesa.handleTipoDespesa(value ?? '');
                                despesa.clearDespesa();
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTitleWidget(
                              title: 'Outros',
                              groupValue: despesa.tipoDespesa ?? '',
                              onChanged: (value) {
                                despesa.handleTipoDespesa(value ?? '');
                                despesa.clearGastoComidaBebida();
                                despesa.clearPessoaSelect();
                              },
                            ),
                          ),
                        ],
                ),
                Column(
                  children: (tipoDespesa != '')
                      ? [
                          if (tipoDespesa == 'Integrante')
                            GastoParticipanteWidget(
                              pessoaModel: pessoaModel,
                            ),
                          if (tipoDespesa == 'Outros')
                            GastoOutroWidget(
                              despesaModel: despesaModel,
                            ),
                        ]
                      : [
                          if (despesa.tipoDespesa == 'Integrante')
                            GastoParticipanteWidget(
                              pessoaModel: pessoaModel,
                            ),
                          if (despesa.tipoDespesa == 'Outros')
                            GastoOutroWidget(
                              despesaModel: despesaModel,
                            ),
                        ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
