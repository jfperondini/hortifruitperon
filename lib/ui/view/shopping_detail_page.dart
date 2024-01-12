import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/domain/model/order_model.dart';

class ShoppingDetailPage extends StatelessWidget {
  final OrderModel orderSelect;
  const ShoppingDetailPage({Key? key, required this.orderSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Detalhes da Compra', style: TextStyle(color: Styles.black)),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      body: Padding(
        padding: Paddings.edgeInsets,
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                color: Styles.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: Paddings.edgeInsets,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data ${orderSelect.datePurchase}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: size.width,
              height: size.height * 0.55,
              decoration: BoxDecoration(
                color: Styles.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height * 0.5,
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.all(10)),
                    shrinkWrap: true,
                    itemCount: orderSelect.listOrderItemModel.length,
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
                                    base64Decode(orderSelect.listOrderItemModel[index].productModel.photo),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderSelect.listOrderItemModel[index].productModel.name,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'R\$ ${orderSelect.listOrderItemModel[index].productModel.price}',
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
                                    const SizedBox(height: 3),
                                    Text(
                                      '${orderSelect.listOrderItemModel[index].quantity}x  R\$ ${orderSelect.listOrderItemModel[index].valueItem}',
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
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub-Total',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Styles.grey,
                      ),
                    ),
                    Text(
                      '${orderSelect.subTotalAmount}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Styles.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Divider(
                  height: 30,
                  color: Styles.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pagamento',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Styles.black,
                      ),
                    ),
                    Text(
                      '${orderSelect.totalAmount}',
                      style: TextStyle(
                        fontSize: 20.0,
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
      ),
    );
  }
}
