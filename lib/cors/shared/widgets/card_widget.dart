import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Color? color;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final Function()? onTap;

  const CardWidget({
    super.key,
    this.color,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        shadowColor: Styles.black.withOpacity(0.8),
        color: Styles.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: color ?? Styles.orange,
            width: 1.8,
          ),
        ),
        child: ListTile(
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          leading: leading,
          onTap: onTap,
        ),
      ),
    );
  }
}
