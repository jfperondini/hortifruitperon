import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/elevated_button_widget.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/data/services/auth_exception.dart';
import 'package:hortifruitperon/ui/controller/category_controller.dart';

class CategoryRegisterPage extends StatelessWidget {
  const CategoryRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Modular.get<CategoryController>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Cadastre uma novo categoria', style: TextStyle(color: Styles.black)),
        leading: IconButton(
          onPressed: () async {
            await category.clearCategory();
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
                  listenable: category,
                  builder: (context, child) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Styles.white,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                        ),
                        width: 150,
                        height: 150,
                        child: Center(
                          child: (category.hasImage)
                              ? Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: MemoryImage(
                                        category.bytes ?? Uint8List(0),
                                      ),
                                    ),
                                  ),
                                )
                              : Icon(Icons.image_outlined, color: Styles.grey, size: 100),
                        ),
                      ),
                      onTap: () async {
                        await category.getImageGallery();
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                TextFormFieldWidget(
                  controller: category.typeName,
                  inputFormatters: const [],
                  hintText: 'tipo de categoria do produto',
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o tipo de categoria do produto corretamente';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButtonWidget(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      try {
                        await category.putCategory();
                        await category.clearCategory();
                        Modular.to.pop();
                      } on AuthException catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message), backgroundColor: Styles.redAccent),
                        );
                      }
                    }
                  },
                  title: 'Addiconar Categoria',
                  icon: Icons.category,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
