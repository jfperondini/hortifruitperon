import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/plus_minus_button_widget.dart';
import 'package:hortifruitperon/cors/shared/widgets/right_aligned_button_widget.dart';
import 'package:hortifruitperon/domain/model/product_model.dart';
import 'package:hortifruitperon/ui/controller/order_controller.dart';
import 'package:hortifruitperon/ui/controller/product_controller.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Modular.get<ProductController>();
    final order = Modular.get<OrderController>();
    ProductModel? productModel = Modular.get<ProductController>().productSelect;
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        backgroundColor: Styles.white,
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Styles.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Styles.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.elliptical(150, 45),
              ),
            ),
            child: Center(
              child: Image.memory(
                base64Decode(productModel?.photo ?? ''),
                height: 200,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: Paddings.edgeInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productModel?.name ?? '',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: product,
                      builder: (context, child) {
                        return PlusMinusButtonWidget(
                          deleteQuantity: () {
                            product.decreaseQuantity();
                          },
                          title: product.quantity.toString(),
                          addQuantity: () {
                            product.increaseQuantity();
                          },
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  'R\$ ${productModel?.price ?? ''}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Styles.redAccent,
                  ),
                ),
                const SizedBox(height: 20.0),
                if (order.userSelect?.isAdmin != true)
                  RightAlignedButtonWidget(
                    onPressed: () async {
                      await order.setOrder();
                      await order.setItemOrder(
                        quantity: product.quantity,
                        productModel: product.productSelect ?? ProductModel.empty(),
                      );
                      await product.clearQuantity();
                      await Modular.to.pushNamed(Routes.order);
                    },
                    title: 'Add no Carrinho',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
