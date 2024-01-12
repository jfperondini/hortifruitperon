import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum CardType { Master, Visa, AmericanExpress, Others, Invalid }

class CardUtils {
  static String firstDigit(int num) {
    return num.toString().substring(0, 1);
  }

  static String lastFourDigits(int num) {
    String texto = num.toString();
    return texto.substring(texto.length - 4);
  }

  static String getCleanNum(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static CardType getCardTypeFrmNum(String input) {
    CardType cardType;
    if (RegExp(r'^[5]').hasMatch(input)) {
      cardType = CardType.Master;
    } else if (RegExp(r'^[4]').hasMatch(input)) {
      cardType = CardType.Visa;
    } else if (RegExp(r'^[6]').hasMatch(input)) {
      cardType = CardType.AmericanExpress;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static Widget? getCardIcon(CardType? cardType) {
    String img = "";
    Icon? icon;
    switch (cardType) {
      case CardType.Master:
        img = 'mastercard.png';
        break;
      case CardType.Visa:
        img = 'visa.png';
        break;
      case CardType.AmericanExpress:
        img = 'american_express.png';
        break;
      case CardType.Others:
        icon = const Icon(
          Icons.credit_card,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
      default:
        icon = const Icon(
          Icons.warning,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = Image.asset(
        'assets/images/$img',
        width: 40.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }

  static String getCardFlagText(String firstDigit) {
    switch (firstDigit) {
      case '4':
        return 'Visa';
      case '5':
        return 'MasterCard';
      // Add more cases for other card types if needed
      default:
        return 'Unknown Card';
    }
  }
}
