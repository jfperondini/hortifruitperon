import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/data/services/auth_exception.dart';
import 'package:hortifruitperon/ui/controller/user_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Modular.get<UserController>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Perfil', style: TextStyle(color: Styles.black)),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Paddings.edgeInsets,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ListenableBuilder(
                  listenable: user,
                  builder: (context, child) {
                    return GestureDetector(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Styles.white,
                        child: (user.hasImage)
                            ? ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.elliptical(100, 100)),
                                child: Image.memory(
                                  user.bytes ?? Uint8List(0),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(Icons.person, color: Styles.grey, size: 60),
                      ),
                      onTap: () async {
                        await user.getImageGallery();
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                TextFormFieldWidget(
                  controller: user.name,
                  inputFormatters: null,
                  textInputAction: TextInputAction.next,
                  hintText: user.userSelect?.name ?? 'nome',
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value != "") {
                      return 'Informe o nome corretamente';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  controller: user.phone,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')}),
                    LengthLimitingTextInputFormatter(15),
                  ],
                  textInputAction: TextInputAction.next,
                  hintText: user.userSelect?.phone ?? 'telefone',
                  keyboardType: TextInputType.phone,
                  validator: (String? value) {
                    if (value != "") {
                      return 'Informe o telefone corretamente';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  controller: user.birthData,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  textInputAction: TextInputAction.done,
                  hintText: user.userSelect?.birth.toString() ?? 'data de aniverário',
                  keyboardType: TextInputType.datetime,
                  validator: (String? value) {
                    if (value != "") {
                      return 'Informe o data do nascimento corretamente';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Styles.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await user.setUser(
                          id: user.userSelect?.id,
                        );
                        await Modular.to.popAndPushNamed(Routes.home);
                      } on AuthException catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message),
                            backgroundColor: Styles.redAccent,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(fontSize: 20),
                    ),
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
