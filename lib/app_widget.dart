import 'package:drinkeat/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bebeu e Comeu?',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.white,
        appBarTheme: AppBarTheme(
          color: Styles.transparent,
          elevation: 0.0,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Styles.orange,
        ),
      ),
      routerConfig: Modular.routerConfig,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
