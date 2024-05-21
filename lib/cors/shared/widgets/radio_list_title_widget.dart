import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class RadioListTitleWidget<T> extends StatelessWidget {
  final String title;
  final Function(String?)? onChanged;
  final String groupValue;

  const RadioListTitleWidget({
    super.key,
    required this.title,
    required this.onChanged,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(title),
      value: title,
      groupValue: groupValue,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeColor: Styles.orange,
    );
  }
}
