import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hortifruitperon/cors/shared/styles/padding.dart';
import 'package:hortifruitperon/cors/shared/styles/styles.dart';
import 'package:hortifruitperon/cors/shared/utils/card_utils.dart';
import 'package:hortifruitperon/cors/shared/widgets/elevated_button_widget.dart';
import 'package:hortifruitperon/cors/shared/widgets/text_form_field_widget.dart';
import 'package:hortifruitperon/ui/controller/card_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardRegisterPage extends StatefulWidget {
  const CardRegisterPage({super.key});

  @override
  State<CardRegisterPage> createState() => _CardRegisterPageState();
}

class _CardRegisterPageState extends State<CardRegisterPage> {
  final card = Modular.get<CardController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await card.initCardNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Styles.backgroud,
      appBar: AppBar(
        title: Text('Cadastre um novo cartão', style: TextStyle(color: Styles.black)),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
            card.clearCard();
          },
          icon: Icon(Icons.chevron_left_outlined, color: Styles.black),
        ),
      ),
      body: AnimatedBuilder(
        animation: card,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: Paddings.edgeInsets,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      controller: card.number,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')}),
                        LengthLimitingTextInputFormatter(19),
                      ],
                      hintText: 'numero do cartão',
                      suffixIcon: CardUtils.getCardIcon(card.cardType),
                      keyboardType: TextInputType.number,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o numero do cartão corretamente';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      controller: card.name,
                      inputFormatters: const [],
                      hintText: 'nome completo',
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o nome completo corretamente';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: card.cvv,
                            inputFormatters: [
                              MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')}),
                              LengthLimitingTextInputFormatter(4),
                            ],
                            hintText: 'cvv',
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Este campo é obrigatório";
                              }
                              if (value.length < 3 || value.length > 4) {
                                return "cvv é inválido";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: card.data,
                            inputFormatters: [
                              MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')}),
                              LengthLimitingTextInputFormatter(5),
                            ],
                            hintText: 'mm/yy',
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor insira uma data';
                              }

                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButtonWidget(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          await card.putCard();
                          await card.clearCard();
                          Modular.to.pop();
                        }
                      },
                      title: 'Addiconar Cartão',
                      icon: Icons.credit_card,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
