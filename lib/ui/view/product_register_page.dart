import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/elevated_button_widget.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/data/services/auth_exception.dart';
import 'package:hortifruitperon/domain/model/category_model.dart';
import 'package:hortifruitperon/ui/controller/category_controller.dart';
import 'package:hortifruitperon/ui/controller/product_controller.dart';

class ProductRegisterPage extends StatelessWidget {
  const ProductRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Modular.get<CategoryController>();
    final product = Modular.get<ProductController>();
    final formKey = GlobalKey<FormState>();
    return ListenableBuilder(
        listenable: product,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Styles.backgroud,
            appBar: AppBar(
              title: Text('Cadastre uma novo produto', style: TextStyle(color: Styles.black)),
              leading: IconButton(
                onPressed: () async {
                  await product.clearProduct();
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
                        listenable: product,
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
                                child: (product.hasImage)
                                    ? Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(
                                              product.bytes ?? Uint8List(0),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Icon(Icons.image_outlined, color: Styles.grey, size: 100),
                              ),
                            ),
                            onTap: () async {
                              await product.getImageGallery();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        controller: product.name,
                        inputFormatters: const [],
                        hintText: 'nome do produto',
                        keyboardType: TextInputType.name,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o nome do produto corretamente';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        controller: product.price,
                        inputFormatters: const [],
                        hintText: 'preço do produto',
                        keyboardType: TextInputType.number,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe o preço do produto corretamente';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Selecione uma categoria'),
                          DropdownButton<CategoryModel>(
                            value: product.categorySelect,
                            items: category.listCategory
                                .map(
                                  (e) => DropdownMenuItem<CategoryModel>(
                                    value: e,
                                    child: Text(e.typeName),
                                  ),
                                )
                                .toList(),
                            onChanged: (CategoryModel? value) async {
                              if (value != null || value != CategoryModel.empty()) {
                                await product.valueDropDownCategory(value);
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButtonWidget(
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            try {
                              await product.putProduct();

                              await product.clearProduct();
                              Modular.to.pop();
                            } on AuthException catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message),
                                  backgroundColor: Styles.redAccent,
                                ),
                              );
                            }
                          }
                        },
                        title: 'Addiconar Produto',
                        icon: Icons.inventory,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
