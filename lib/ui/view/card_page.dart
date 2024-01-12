import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/routes/routes.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/utils/card_utils.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/ui/controller/card_controller.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final card = Modular.get<CardController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await card.getListCard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Cartões', style: TextStyle(color: Styles.black)),
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
            TextFormFieldWidget(
              controller: card.add,
              inputFormatters: const [],
              readOnly: true,
              hintText: 'Cadastrar um novo cartão',
              prefixIcon: Icon(Icons.credit_card, color: Styles.green),
              onTap: () async {
                await Modular.to.pushNamed(Routes.cardRegister);
              },
            ),
            const SizedBox(height: 10),
            ListenableBuilder(
              listenable: card,
              builder: (context, child) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: size.height - 200,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: card.listCard.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shadowColor: Styles.backgroud,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Styles.backgroud,
                                      child: CardUtils.getCardIcon(
                                          CardUtils.getCardTypeFrmNum(card.listCard[index].number.toString()))),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text('Terminado em ${CardUtils.lastFourDigits(card.listCard[index].number)}'),
                                  const SizedBox(height: 5),
                                  Text(CardUtils.getCardFlagText(CardUtils.firstDigit(card.listCard[index].number))),
                                  const SizedBox(height: 5),
                                  Text('Vencimento: ${card.listCard[index].data}'),
                                  const SizedBox(height: 20),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      card.deleteCard(index);
                                    },
                                    child: const Text('excluir'),
                                  ),
                                ],
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
