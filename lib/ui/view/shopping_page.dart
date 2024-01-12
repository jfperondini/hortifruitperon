import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/widgets/elevated_button_widget.dart';
import 'package:hortifruitperon/ui/controller/order_controller.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final order = Modular.get<OrderController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await order.getListOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Compras', style: TextStyle(color: Styles.black)),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      body: Padding(
        padding: Paddings.edgeInsets,
        child: ListenableBuilder(
          listenable: order,
          builder: (context, child) {
            return SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                width: double.infinity,
                child: order.listOrder.isEmpty
                    ? Center(
                        child: Text(
                          'Não há nenhuma compra efetuada.',
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
                        itemCount: order.listOrder.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Data ${order.listOrder[index].datePurchase}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Valor Total R\$ ${order.listOrder[index].totalAmount}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Styles.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButtonWidget(
                                      onPressed: () {
                                        Modular.to.pushNamed(
                                          Routes.shoppingDetail,
                                          arguments: order.listOrder[index],
                                        );
                                      },
                                      icon: Icons.chevron_right_outlined,
                                      title: '',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
