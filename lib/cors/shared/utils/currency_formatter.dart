import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;
    num value = num.parse(newValue.text);
    final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    String newText = formatter.format(value / 100).replaceAll('R\$', '').trim();
    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }
}
