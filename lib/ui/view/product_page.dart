import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/domain/model/category_model.dart';
import 'package:hortifruitperon/ui/controller/product_controller.dart';

class ProductPage extends StatefulWidget {
  final CategoryModel categoryModel;
  final String? searcProduct;

  const ProductPage({
    super.key,
    required this.categoryModel,
    required this.searcProduct,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final product = Modular.get<ProductController>();
  String get searc => widget.searcProduct ?? '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      product.categorySelect = widget.categoryModel;
      await product.filterListProduct(
        categoryModel: widget.categoryModel,
        searcProduct: widget.searcProduct ?? '',
      );
    });
  }

  @override
  void dispose() {
    product.listFilterProduto.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: product,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Styles.backgroud,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Modular.to.pop();
              },
              icon: Icon(
                Icons.chevron_left_outlined,
                color: Styles.black,
              ),
            ),
            title: Text(
              (searc.isNotEmpty) ? 'Produto' : widget.categoryModel.typeName,
              style: TextStyle(color: Styles.black),
            ),
          ),
          body: Padding(
            padding: Paddings.edgeInsets,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 230,
              ),
              itemCount: product.listFilterProduto.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    await product.setProduct(index);
                    await Modular.to.pushNamed(Routes.productDetail);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Styles.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.memory(
                          base64Decode(product.listFilterProduto[index].photo),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          product.listFilterProduto[index].name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R\$ ${product.listFilterProduto[index].price.toString()}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Styles.redAccent,
                              ),
                            ),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Styles.green,
                              child: Icon(Icons.add, color: Styles.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
