import 'package:drinkeat/app_module.dart';
import 'package:drinkeat/app_widget.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: ClientEndPoint.baseUrl,
    anonKey: '${ClientEndPoint.apiKey}: ${ClientEndPoint.key}',
  );
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
