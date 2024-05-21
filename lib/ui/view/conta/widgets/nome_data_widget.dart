import 'package:drinkeat/cors/shared/extension/data_extension.dart';
import 'package:drinkeat/cors/shared/utils/input_formatter.dart';
import 'package:drinkeat/cors/shared/widgets/text_form_field_widget.dart';
import 'package:drinkeat/ui/controller/conta_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NameDateWidget extends StatelessWidget {
  const NameDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    final conta = Modular.get<ContaController>();
    final inputFormatter = InputFormatter();
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: conta.data,
            readOnly: true,
            prefixIcon: Icons.event_note,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
                locale: const Locale('pt', 'BR'),
              );
              if (picked != null) {
                conta.data.text = picked.formatDateTime;
              }
            },
            validator: inputFormatter.data.validator,
          ),
          SizedBox(height: size.height * 0.02),
          TextFormFieldWidget(
            controller: conta.nome,
            hintText: 'nome',
            keyboardType: inputFormatter.nome.keyboardType,
            textInputAction: TextInputAction.done,
            prefixIcon: Icons.receipt_long,
          ),
        ],
      ),
    );
  }
}
