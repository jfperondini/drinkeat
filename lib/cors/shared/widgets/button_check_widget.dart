import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class ButtonCheckWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  final bool opcaoSelecionada;

  const ButtonCheckWidget({
    super.key,
    required this.onTap,
    required this.opcaoSelecionada,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: opcaoSelecionada ? Styles.orange : Styles.grey,
          ),
          borderRadius: BorderRadius.circular(5),
          color: opcaoSelecionada ? Styles.orange.withOpacity(0.3) : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Styles.black.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
