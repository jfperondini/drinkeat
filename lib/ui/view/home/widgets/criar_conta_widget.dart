import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CriarContaWidget extends StatelessWidget {
  const CriarContaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final home = Modular.get<HomeController>();
    return Column(
      children: [
        SizedBox(
            height: size.height * 0.3,
            child: Image.asset(
              'assets/churrasqueira.png',
              fit: BoxFit.cover,
            )),
        SizedBox(height: size.height * 0.02),
        // Text(
        //   'Conta Vazia',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 18,
        //     color: Styles.black.withOpacity(0.8),
        //   ),
        // ),
        Text(
          'Ainda não tem uma conta?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Styles.grey,
          ),
        ),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          width: size.height * 0.32,
          height: size.width * 0.1,
          child: ElevatedButtonWidget(
            onPressed: () async {
              if (home.contaSelect == null) {
                await home.creatConta();
              }
              await Modular.to.pushNamed(Routes.conta);
            },
            title: 'Criar Nova Conta',
          ),
        ),
      ],
    );
  }
}
