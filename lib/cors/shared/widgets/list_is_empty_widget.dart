import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class ListIsEmptyWidget extends StatelessWidget {
  final double? height;
  final String title;

  const ListIsEmptyWidget({
    super.key,
    required this.height,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          'Lista de $title Vazia',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Styles.grey,
          ),
        ),
      ),
    );
  }
}
