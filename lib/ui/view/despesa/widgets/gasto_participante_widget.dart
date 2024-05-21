import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/utils/input_formatter.dart';
import 'package:drinkeat/cors/shared/widgets/drop_down_widget.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/cors/shared/widgets/text_form_field_widget.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita.dart';
import 'package:drinkeat/ui/controller/despesa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class GastoParticipanteWidget extends StatelessWidget {
  final PessoaFavoritaModel? pessoaModel;
  const GastoParticipanteWidget({super.key, required this.pessoaModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final despesa = Modular.get<DespesaController>();
    final inputFormatter = InputFormatter();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return ListenableBuilder(
      listenable: despesa,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownWidget<PessoaFavoritaModel>(
              enabled: (pessoaModel?.nome != '') ? false : true,
              items: despesa.filterListPessoaFavorita(),
              itemAsString: (PessoaFavoritaModel pessoa) => pessoa.nome,
              onChanged: (PessoaFavoritaModel? pessoaSelect) async {
                if (despesa.contaSelect.listPessoaFavorita.isNotEmpty) {
                  await despesa.handlePessoaSelect(pessoaModel: pessoaSelect);
                }
              },
              hintText: (pessoaModel?.nome != '') ? pessoaModel?.nome : despesa.pessoaSelect?.nome ?? 'Selecionar uma pessoa',
            ),
            if (despesa.pessoaSelect != null || pessoaModel?.nome != '')
              Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  TextFormFieldWidget(
                    controller: despesa.valorComida,
                    inputFormatters: inputFormatter.moedaR$.formatter,
                    hintText: (pessoaModel?.nome != '')
                        ? real.format(pessoaModel?.gasto.valorComida ?? 0.00)
                        : real.format(despesa.contaSelect.listPessoaFavorita[despesa.isPessoaSelect].gasto.valorComida),
                    keyboardType: inputFormatter.moedaR$.keyboardType,
                    prefixIcon: Icons.lunch_dining,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: size.height * 0.015),
                  TextFormFieldWidget(
                    controller: despesa.valorBebida,
                    inputFormatters: inputFormatter.moedaR$.formatter,
                    hintText: (pessoaModel?.nome != '')
                        ? real.format(pessoaModel?.gasto.valorBebida ?? 0.00)
                        : real.format(despesa.contaSelect.listPessoaFavorita[despesa.isPessoaSelect].gasto.valorBebida),
                    keyboardType: inputFormatter.moedaR$.keyboardType,
                    prefixIcon: Icons.liquor,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: size.height * 0.02),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      despesa.creatGastoParcipante(
                        despesa.isPessoaSelect,
                        pessoaModel ?? PessoaFavoritaModel.empty(),
                      );
                      despesa.clearGastoComidaBebida();
                      despesa.clearPessoaSelect();
                      despesa.clearTipoDespesa();
                      Modular.to.popAndPushNamed(Routes.conta);
                    },
                    title: 'Addicionar',
                  )
                ],
              ),
          ],
        );
      },
    );
  }
}
