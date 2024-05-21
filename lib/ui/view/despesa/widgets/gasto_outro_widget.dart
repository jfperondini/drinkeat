// ignore_for_file: use_build_context_synchronously
import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/utils/input_formatter.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/cors/shared/widgets/text_form_field_widget.dart';
import 'package:drinkeat/domain/model/conta/despesa_model.dart';
import 'package:drinkeat/ui/controller/despesa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class GastoOutroWidget extends StatelessWidget {
  final DespesaModel? despesaModel;

  const GastoOutroWidget({super.key, required this.despesaModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final despesa = Modular.get<DespesaController>();
    final inputFormatter = InputFormatter();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormFieldWidget(
          readOnly: (despesaModel?.tipo != '') ? true : false,
          controller: despesa.tipo,
          hintText: (despesaModel?.tipo != '') ? despesaModel?.tipo : 'tipo de despesa',
          keyboardType: inputFormatter.nome.keyboardType,
          prefixIcon: Icons.class_outlined,
          validator: inputFormatter.nome.validator,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: size.height * 0.02),
        TextFormFieldWidget(
          controller: despesa.valor,
          hintText: (despesaModel?.valor != 0.00) ? real.format(despesaModel?.valor ?? 0.00) : 'valor da despesa',
          inputFormatters: inputFormatter.moedaR$.formatter,
          keyboardType: inputFormatter.moedaR$.keyboardType,
          prefixIcon: Icons.attach_money,
          validator: inputFormatter.moedaR$.validator,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: size.height * 0.02),
        ElevatedButtonWidget(
          onPressed: () async {
            if (despesa.tipo.text != '' && despesa.valor.text != '') {
              despesa.creatDespesa();
              despesa.clearPessoaSelect();
              despesa.clearTipoDespesa();
              Modular.to.popAndPushNamed(Routes.conta);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    (despesa.tipo.text == '' && despesa.valor.text == '')
                        ? 'Por favor, preencha os campos que estão vazios.'
                        : (despesa.valor.text == '')
                            ? 'O valor da despesa não pode ser vazio.'
                            : 'O tipo de despesa não pode ser vazio.',
                  ),
                  backgroundColor: Styles.redAccent,
                ),
              );
            }
          },
          title: "Addicionar",
        )
      ],
    );
  }
}
