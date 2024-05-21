import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String? title;
  final IconData? icon;

  const ElevatedButtonWidget({
    Key? key,
    required this.onPressed,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Styles.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: BorderSide(
            color: Styles.black.withOpacity(0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title?.isNotEmpty ?? false)
              Text(
                title ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Styles.black.withOpacity(0.8),
                ),
              ),
            if (icon != null)
              Icon(
                icon,
                color: Styles.black.withOpacity(0.8),
              ),
          ],
        ),
      ),
    );
  }
}
