import 'package:drinkeat/cors/shared/utils/currency_formatter.dart';
import 'package:drinkeat/domain/model/input_formatter_model.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatter {
  InputFormatterModel get nome => InputFormatterModel(
          formatter: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
          ],
          keyboardType: TextInputType.name,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'o nome não pode ser vazio';
            }
            return null;
          });

  InputFormatterModel get moedaR$ => InputFormatterModel(
        formatter: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          CurrencyFormatter(),
        ],
        keyboardType: TextInputType.number,
        validator: (text) {
          if (text == null || text.trim().isEmpty) {
            return 'o valor não pode ser vazio';
          }
          return null;
        },
      );

  InputFormatterModel get data => InputFormatterModel(
        formatter: [
          MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: TextInputType.number,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "Data Obrigátória";
          }
          // if (text.length < 10) {
          //   return "Data incompleta 00/00/0000";
          // }
          return null;
        },
      );
}
