// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/data/services/auth_exception.dart';
import 'package:hortifruitperon/ui/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final login = Modular.get<LoginController>();

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Modular.to.popAndPushNamed(Routes.intro);
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      backgroundColor: Styles.backgroud,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 18, right: 18),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Styles.grey,
                  foregroundImage: const AssetImage(
                    'assets/images/logo.jpg',
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Digite seu e-mail para entrar em uma conta',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormFieldWidget(
                  controller: login.email,
                  inputFormatters: null,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    final exp = RegExp(r"^([\w\-_]+)(@+)([\w]+)((\.+\w{2,3}){1,2})$");
                    if (exp.hasMatch(value ?? '') == false) {
                      return 'Informe um email válido';
                    }
                    return null;
                  },
                ),
                ListenableBuilder(
                    listenable: login,
                    builder: (context, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(login.valueIsAdmin ? 'Logar como Admin' : 'Logar como Cliente'),
                          Checkbox(
                            value: login.valueIsAdmin,
                            onChanged: (bool? value) {
                              if (value != null) {
                                login.toggleIsAdmin();
                              }
                            },
                          ),
                        ],
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        try {
                          await login.setRegister();
                          await login.getRoute();
                          await login.clearLogin();
                        } on AuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message), backgroundColor: Styles.redAccent),
                          );
                        }
                      }
                    },
                    child: const Text('Continuar', style: TextStyle(fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
