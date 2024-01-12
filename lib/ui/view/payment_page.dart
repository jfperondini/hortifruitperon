import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/extension/doube_extesion.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/utils/card_utils.dart';
import 'package:hortifruitperon/cors/shared/widgets/elevated_button_widget.dart';
import 'package:hortifruitperon/ui/controller/card_controller.dart';
import 'package:hortifruitperon/ui/controller/order_controller.dart';
import 'package:hortifruitperon/ui/controller/payment_controller.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final payment = Modular.get<PaymentController>();
  final card = Modular.get<CardController>();
  final order = Modular.get<OrderController>();

  @override
  void initState() {
    payment.setTotalAmout();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await card.getListCard();
    });
  }

  init() async {
    Future.delayed(const Duration(seconds: 3), () async {
      await payment.setPayment(amountPaid: payment.orderSelect?.totalAmount ?? 0.00);
      await order.putOrder();
      Modular.to.pushNamedAndRemoveUntil(Routes.home, (p0) => false);
      await order.clearOrder();
      await card.clearCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.backgroud,
      bottomNavigationBar: BottomAppBar(
        height: size.height * 0.35,
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
                      'Sub-Total',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Styles.grey,
                      ),
                    ),
                    Text(
                      '${payment.orderSelect?.subTotalAmount.toPrecision(2) ?? 0.00}',
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
                      '${payment.orderSelect?.totalAmount ?? 0.00}',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Styles.redAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                AnimatedBuilder(
                  animation: card,
                  builder: (context, child) {
                    return (card.listCard.isNotEmpty)
                        ? ElevatedButtonWidget(
                            onPressed: () async {
                              if (order.orderSelect?.paymentModel.cardModel.id != '') {
                                await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return FutureBuilder(
                                        future: init(),
                                        builder: (context, snapshot) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 50),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const CircularProgressIndicator(),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'efetuando pagamento...',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 22,
                                                      letterSpacing: 0.27,
                                                      color: Styles.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: const Text('Selecionar um cartão valido'),
                                      backgroundColor: Styles.redAccent),
                                );
                              }
                            },
                            title: 'Confirmar Pagamento',
                            icon: Icons.credit_score,
                          )
                        : ElevatedButtonWidget(
                            onPressed: () async {
                              Modular.to.pushNamed(Routes.cardRegister);
                            },
                            title: 'Cadastrar Cartão',
                            icon: Icons.credit_score,
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Pagamento',
          style: TextStyle(color: Styles.black),
        ),
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
            ListenableBuilder(
              listenable: card,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: size.height - 500,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: card.listCard.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 10,
                          shadowColor: Styles.backgroud,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: RadioListTile(
                                  title: Text(
                                      CardUtils.getCardFlagText(CardUtils.firstDigit(card.listCard[index].number))),
                                  subtitle:
                                      Text('*** **** **** ${CardUtils.lastFourDigits(card.listCard[index].number)} '),
                                  value: 0,
                                  groupValue: card.selectedCard,
                                  onChanged: (int? value) async {
                                    await card.chooseCard(value ?? -1);
                                  },
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CardUtils.getCardIcon(
                                    CardUtils.getCardTypeFrmNum(
                                      card.listCard[index].number.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
