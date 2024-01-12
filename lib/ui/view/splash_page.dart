import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 4), () async {
                  await Modular.to.pushNamed(Routes.authCheck);
                }),
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 300,
                    width: 200,
                    child: ClipOval(
                      child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
