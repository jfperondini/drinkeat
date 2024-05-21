import 'package:intl/intl.dart';

DateTime get empatyDate => DateTime.parse("1912-01-30");

DateTime selectedDate = DateTime.now();

extension DateTimeUtils on DateTime {
  bool get isEmpaty => isAtSameMomentAs(empatyDate);
  bool get isNotEmpaty => !isEmpaty;
  String get asString => isEmpaty ? '' : toIso8601String();

  String get formatDateTime => DateFormat('dd/MM/yyyy').format(this);
}
