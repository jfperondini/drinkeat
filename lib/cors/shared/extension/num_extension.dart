import 'package:drinkeat/cors/shared/extension/string_extension.dart';

extension NumUtils on num {
  num toPrecision(int n) => double.parse(toStringAsFixed(n));

  num toPrecisionFloor(num valor) {
    if (valor.isFinite && !valor.isNaN) {
      return (valor / 5).floor() * 5;
    } else {
      return 0.00;
    }
  }

  num toPrecisionCeil(num valor) {
    if (valor.isFinite && !valor.isNaN) {
      return (valor / 5).ceil() * 5;
    } else {
      return 0.00;
    }
  }

  num isMultipleOf(num valor) {
    if (valor.isFinite && !valor.isNaN) {
      num floor = ((valor / 5).floor() * 5);
      num ceil = ((valor / 5).ceil() * 5);
      if ((valor - floor) < (ceil - valor)) {
        return floor;
      } else {
        return ceil;
      }
    } else {
      return 0.00;
    }
  }

  num parseCurrencyInput(String input) {
    if (input.isEmpty) return 0;
    return num.parse(input.toReplaceCoinFormat(input)) / 100;
  }
}
