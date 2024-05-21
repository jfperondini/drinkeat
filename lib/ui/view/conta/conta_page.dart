// ignore_for_file: use_build_context_synchronously
import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/ui/controller/conta_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContaPage extends StatelessWidget {
  const ContaPage({super.key});
  @override
  Widget build(BuildContext context) {
    final conta = Modular.get<ContaController>();
    return ListenableBuilder(
      listenable: conta,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Styles.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: (conta.contaSelect.listPessoaFavorita.isNotEmpty)
                ? null
                : IconButton(
                    onPressed: () async {
                      Modular.to.popAndPushNamed(Routes.init);
                    },
                    icon: Icon(
                      Icons.chevron_left_outlined,
                      color: Styles.black.withOpacity(0.8),
                    ),
                  ),
            title: Text(
              'Nova Conta',
              style: TextStyle(
                color: Styles.black.withOpacity(0.8),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  conta.clearNomeData();
                  conta.clearConta();
                },
                icon: Icon(
                  Icons.delete,
                  color: Styles.black.withOpacity(0.8),
                ),
              )
            ],
          ),
          body: ListenableBuilder(
            listenable: conta,
            builder: (context, snapshot) {
              return PageView.builder(
                controller: PageController(initialPage: conta.currentStep),
                itemCount: conta.getSteps().length,
                itemBuilder: (context, index) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(primary: Styles.orange),
                    ),
                    child: Stepper(
                      type: StepperType.horizontal,
                      steps: conta.getSteps(),
                      currentStep: conta.currentStep,
                      onStepTapped: (step) {
                        conta.stepTapped(step);
                      },
                      controlsBuilder: (context, details) {
                        return Container();
                      },
                    ),
                  );
                },
                onPageChanged: (int page) {
                  conta.stepTapped(page);
                },
              );
            },
          ),
          bottomNavigationBar: BottomAppBar(
            child: ListenableBuilder(
                listenable: conta,
                builder: (context, snapshot) {
                  final isLastStep = conta.currentStep == conta.getSteps().length - 1;
                  return Row(
                    mainAxisAlignment: (conta.currentStep == 0) ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
                    children: [
                      if (conta.currentStep != 0)
                        ElevatedButtonWidget(
                          onPressed: () {
                            conta.stepCancel();
                          },
                          title: 'Voltar',
                        ),
                      ElevatedButtonWidget(
                        onPressed: () async {
                          String? result = await conta.stepContinue();
                          if (result != null) {
                            return ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result),
                                backgroundColor: Styles.redAccent,
                              ),
                            );
                          }
                        },
                        title: isLastStep ? 'Calcular' : 'Próximo',
                      )
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}
