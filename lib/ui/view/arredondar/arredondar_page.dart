import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/widgets/button_check_widget.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/ui/controller/arredondar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class ArredondarPage extends StatelessWidget {
  const ArredondarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final arredondar = Modular.get<ArredondarController>();
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    return Scaffold(
      backgroundColor: Styles.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            arredondar.clearArredondar();
            Modular.to.pushNamed(Routes.conta);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Styles.black.withOpacity(0.8),
          ),
        ),
        title: Text(
          'Arrendodar Valores',
          style: TextStyle(
            color: Styles.black.withOpacity(0.8),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: arredondar,
        builder: (context, child) {
          return Container(
            height: size.height * 0.41,
            padding: const EdgeInsets.all(18),
            color: Styles.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bebida por Pessoa ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Styles.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  real.format(arredondar.contaSelect.valorArredondado.valorBebidaPessoa),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Styles.black.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Column(
                    children: arredondar.isMultipleOf(value: arredondar.contaSelect.valorArredondado.valorBebidaPessoa)
                        ? [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ButtonCheckWidget(
                                  onTap: () {
                                    arredondar.toggleBebida();
                                  },
                                  opcaoSelecionada: arredondar.isMultipleBebida,
                                  title: real.format(arredondar.contaSelect.valorArredondado.valorBebidaToFloor),
                                ),
                                ButtonCheckWidget(
                                  opcaoSelecionada: !arredondar.isMultipleBebida,
                                  onTap: () {
                                    arredondar.toggleBebida();
                                  },
                                  title: real.format(arredondar.contaSelect.valorArredondado.valorBebidaToCeil),
                                ),
                              ],
                            )
                          ]
                        : []),
                SizedBox(height: size.height * 0.008),
                Text(
                  'Comida por Pessoa ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Styles.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  real.format(arredondar.contaSelect.valorArredondado.valorDiversoComida),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Styles.black.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Column(
                  children: arredondar.isMultipleOf(value: arredondar.contaSelect.valorArredondado.valorDiversoComida)
                      ? [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonCheckWidget(
                                onTap: () {
                                  arredondar.toggleComida();
                                },
                                opcaoSelecionada: arredondar.isMultipComida,
                                title: real.format(arredondar.contaSelect.valorArredondado.valorDiversoComidaToFloor),
                              ),
                              ButtonCheckWidget(
                                opcaoSelecionada: !arredondar.isMultipComida,
                                onTap: () {
                                  arredondar.toggleComida();
                                },
                                title: real.format(arredondar.contaSelect.valorArredondado.valorDiversoComidaToCeil),
                              ),
                            ],
                          )
                        ]
                      : [],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ElevatedButtonWidget(
                onPressed: () async {
                  await arredondar.roundBebida();
                  await arredondar.valorAPagarBebida();
                  await arredondar.roundComida();
                  await arredondar.proportionComida();
                  await arredondar.valorAPagarComida();
                  await arredondar.valorAPagar();
                  await Modular.to.pushNamed(Routes.init);
                },
                title: 'Calcular',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
