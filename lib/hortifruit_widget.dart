import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class HortFruitWidget extends StatelessWidget {
  const HortFruitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Horti Fruit Peron',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.white,
        appBarTheme: AppBarTheme(
          color: Styles.transparent,
          elevation: 0.0,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Styles.green,
        ),
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
