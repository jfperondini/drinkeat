import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class RowTextStyleWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subTitle;

  const RowTextStyleWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 2,
          decoration: BoxDecoration(
            color: Styles.orange,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Styles.black.withOpacity(0.8),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Icon(
                      icon,
                      color: Styles.black.withOpacity(0.8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 3),
                    child: Text(
                      subTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: Styles.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
