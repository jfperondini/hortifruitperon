import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/extension/doube_extesion.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/elevated_button_widget.dart';
import 'package:hortifruitperon/cors/shared/widgets/plus_minus_button_widget.dart';
import 'package:hortifruitperon/domain/model/order_item_model.dart';
import 'package:hortifruitperon/ui/controller/order_controller.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final order = Modular.get<OrderController>();
    List<OrderItemModel> listItem = order.homeController.orderSelect?.listOrderItemModel ?? [];
    return Scaffold(
      backgroundColor: Styles.backgroud,
      bottomNavigationBar: ListenableBuilder(
        listenable: order,
        builder: (context, child) {
          return BottomAppBar(
            height: size.height * 0.22,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total: R\$ ${order.homeController.orderSelect?.subTotalAmount.toPrecision(2) ?? 0.00} ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Styles.redAccent,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Styles.black, thickness: 0.5, height: 30.0),
                    ElevatedButtonWidget(
                      onPressed: () async {
                        if (order.homeController.orderSelect?.listOrderItemModel.isNotEmpty ?? false) {
                          Modular.to.pushNamed(Routes.payment);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: const Text('Sua lista de produto esta vazia'),
                                backgroundColor: Styles.redAccent),
                          );
                        }
                      },
                      title: 'Verificar o pagamento',
                      icon: Icons.payment,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Modular.to.pushNamed(Routes.home);
          },
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Styles.black,
          ),
        ),
        title: Text(
          'Carrinho',
          style: TextStyle(color: Styles.black),
        ),
      ),
      body: ListenableBuilder(
        listenable: order,
        builder: (context, child) {
          return Padding(
            padding: Paddings.edgeInsets,
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height * 0.5,
                child: listItem.isEmpty
                    ? Center(
                        child: Text(
                          'Seu carrinho está vazio.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: Styles.black,
                          ),
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.all(10)),
                        shrinkWrap: true,
                        itemCount: listItem.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Styles.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Styles.white,
                                      foregroundImage: MemoryImage(
                                        base64Decode(listItem[index].productModel.photo),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listItem[index].productModel.name,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'R\$ ${listItem[index].productModel.price}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Styles.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        PlusMinusButtonWidget(
                                          deleteQuantity: () async {
                                            await order.decreaseQuantity(index);
                                          },
                                          title: '${listItem[index].quantity}',
                                          addQuantity: () async {
                                            await order.increaseQuantity(index);
                                          },
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          'R\$ ${listItem[index].valueItem}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Styles.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
