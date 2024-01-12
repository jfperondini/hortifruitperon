import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/ui/controller/auth_controller.dart';
import 'package:hortifruitperon/ui/view/home_page.dart';
import 'package:hortifruitperon/ui/view/intro_page.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Modular.get<AuthController>();
    return FutureBuilder(
      future: auth.authCheckLoading(),
      builder: (context, snapshot) {
        if (auth.authService.user == null) {
          return const IntroPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
