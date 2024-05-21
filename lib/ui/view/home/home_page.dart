import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';
import 'package:drinkeat/ui/view/home/widgets/criar_conta_widget.dart';
import 'package:drinkeat/ui/view/home/widgets/fechar_conta_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final home = Modular.get<HomeController>();
    return Scaffold(
      backgroundColor: Styles.white,
      body: ListenableBuilder(
        listenable: home,
        builder: (context, child) {
          return Padding(
            padding: (home.contaSelect?.listPessoaFavorita.isNotEmpty ?? false)
                ? const EdgeInsets.only(left: 18, right: 18, top: 40)
                : const EdgeInsets.only(left: 18, right: 18),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: (home.contaSelect?.listPessoaFavorita.isNotEmpty ?? false)
                      ? [
                          const FecharContaWidgt(),
                        ]
                      : [
                          const CriarContaWidget(),
                        ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
