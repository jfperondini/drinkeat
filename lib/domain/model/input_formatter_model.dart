import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormatterModel {
  final List<TextInputFormatter>? formatter;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;

  InputFormatterModel({
    required this.formatter,
    this.validator,
    required this.keyboardType,
  });
}
