import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final String? hintText;
  final IconData? prefixIcon;
  final Function()? onTap;

  final Function(String)? onChanged;

  const TextFormFieldWidget({
    Key? key,
    this.controller,
    this.initialValue,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.readOnly,
    this.hintText,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Styles.orange,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Styles.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.orange),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.black.withOpacity(0.8)),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.orange),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Styles.black.withOpacity(0.8),
        ),
        contentPadding: const EdgeInsets.only(left: 18, right: 18),
        prefixIcon: Icon(
          prefixIcon,
          color: Styles.black.withOpacity(0.8),
        ),
      ),
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
