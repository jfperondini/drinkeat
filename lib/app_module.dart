import 'package:drinkeat/cors/client/client_http.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/cors/routes/routes.dart';
import 'package:drinkeat/data/service/conta_service.dart';
import 'package:drinkeat/data/service/despesa_service.dart';
import 'package:drinkeat/data/service/gasto_service.dart';
import 'package:drinkeat/data/service/pagamento_service.dart';
import 'package:drinkeat/data/service/pessoa_favorita_service.dart';
import 'package:drinkeat/data/service/pessoa_service.dart';
import 'package:drinkeat/ui/controller/arredondar_controller.dart';
import 'package:drinkeat/ui/controller/conta_controller.dart';
import 'package:drinkeat/ui/controller/despesa_controller.dart';
import 'package:drinkeat/ui/controller/home_controller.dart';
import 'package:drinkeat/ui/controller/pessoa_controller.dart';
import 'package:drinkeat/ui/view/arredondar/arredondar_page.dart';
import 'package:drinkeat/ui/view/conta/conta_page.dart';
import 'package:drinkeat/ui/view/despesa/despesa_page.dart';
import 'package:drinkeat/ui/view/pessoa/pessoa_page.dart';
import 'package:drinkeat/ui/view/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ClientIHttp>(ClientHttp.start);

    i.addLazySingleton(PessoaService.new);
    i.addLazySingleton(ContaService.new);
    i.addLazySingleton(DespesaService.new);
    i.addLazySingleton(PessoaFavoritaService.new);
    i.addLazySingleton(GastoService.new);
    i.addLazySingleton(PagamentoService.new);

    i.addSingleton(HomeController.new);
    i.addSingleton(ContaController.new);
    i.addSingleton(PessoaController.new);
    i.addSingleton(DespesaController.new);
    i.addSingleton(ArredondarController.new);
  }

  @override
  void routes(r) {
    r.child(Routes.init, child: (_) => const HomePage());
    r.child(Routes.conta, child: (_) => const ContaPage());
    r.child(Routes.pessoa, child: (_) => const PessoaPage());
    r.child(Routes.despesa, child: (_) => DespesaPage(args: r.args.data));
    r.child(Routes.arredondar, child: (_) => const ArredondarPage());
  }
}
