// ignore_for_file: use_build_context_synchronously
import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:drinkeat/cors/shared/utils/input_formatter.dart';
import 'package:drinkeat/cors/shared/widgets/card_widget.dart';
import 'package:drinkeat/cors/shared/widgets/elevated_button_widget.dart';
import 'package:drinkeat/cors/shared/widgets/list_is_empty_widget.dart';
import 'package:drinkeat/cors/shared/widgets/text_form_field_widget.dart';
import 'package:drinkeat/ui/controller/pessoa_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PessoaPage extends StatefulWidget {
  const PessoaPage({Key? key}) : super(key: key);

  @override
  State<PessoaPage> createState() => _PessoaPageState();
}

class _PessoaPageState extends State<PessoaPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    final inputFormatter = InputFormatter();
    final pessoa = Modular.get<PessoaController>();
    return ListenableBuilder(
        listenable: pessoa,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Styles.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () async {
                  await pessoa.filterIsFavorite();
                  Modular.to.pop();
                },
                icon: Icon(
                  Icons.chevron_left_outlined,
                  color: Styles.black.withOpacity(0.8),
                ),
              ),
              title: Text(
                'Pessoas',
                style: TextStyle(
                  color: Styles.black.withOpacity(0.8),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext contextDialog) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Form(
                            key: formKey,
                            child: Container(
                              height: size.height * 0.22,
                              padding: const EdgeInsets.all(18),
                              color: Styles.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormFieldWidget(
                                    controller: pessoa.name,
                                    hintText: 'nome da pessoa',
                                    keyboardType: inputFormatter.nome.keyboardType,
                                    prefixIcon: Icons.person,
                                    validator: inputFormatter.nome.validator,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  ElevatedButtonWidget(
                                    onPressed: () async {
                                      if (formKey.currentState?.validate() ?? false) {
                                        Modular.to.pop();
                                        String? result = await pessoa.createPessoa();
                                        if (result != null) {
                                          ScaffoldMessenger.of(contextDialog).showSnackBar(
                                            SnackBar(
                                              content: Text(result),
                                              backgroundColor: Styles.redAccent,
                                            ),
                                          );
                                        }
                                        await pessoa.clearNome();
                                      }
                                    },
                                    title: "Adicionar",
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.person_add,
                    color: Styles.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: size.height * 0.80,
                    child: (pessoa.listPessoa.isNotEmpty)
                        ? ListView.builder(
                            itemCount: pessoa.listPessoa.length,
                            itemBuilder: (context, index) {
                              return CardWidget(
                                color: (pessoa.listPessoa[index].favorito) ? Styles.orange : Styles.black.withOpacity(0.8),
                                title: Text(pessoa.listPessoa[index].nome),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await pessoa.deleteById(pessoa: pessoa.listPessoa[index]);
                                        await pessoa.getListPessoa();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Styles.black.withOpacity(0.8),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        pessoa.toggleIsFavorite(index: index);
                                      },
                                      icon: Icon(
                                        (pessoa.listPessoa[index].favorito) ? Icons.star : Icons.star_border_outlined,
                                        color: (pessoa.listPessoa[index].favorito) ? Styles.orange : Styles.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : ListIsEmptyWidget(height: size.height * 0.70, title: 'Pessoa'),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButtonWidget(
                      onPressed: () async {
                        await pessoa.filterIsFavorite();
                        Modular.to.pop();
                      },
                      title: 'Addiconar',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
